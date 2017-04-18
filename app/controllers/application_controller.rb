require 'mechanize'
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def hello
    name = "torinist"
    render text: "Hello, #{name}, Welcome to Ruby!"
  end

  
  def search_mecha(word,cost,time)
	  @menu_other  = Array.new
	  @material  =Array.new
	  agent = Mechanize.new
	  resp = agent.get('https://recipe.rakuten.co.jp/search/'+word+'/?s=4&v=0&t=2&cost='+cost+'&time='+time+'')
	  @title = resp.search("h2.cateResultTit").inner_text
	  top_search(resp)
	  mech_loop(@menu_other,@material,resp,5)
	  return @menu_other,@material,@title
  end
  
  def mech_loop(title,material,resp,number)
	  num = 1
	while num <= number do 
	  	if number != 1 
	  		page  = resp.link_with(:text=>"#{number}").click
			meti_pick(title,material,page)
	  	else
			meti_pick(title,material,resp)
	  	end
		num  = num + 1
	  end
  end

  def meti_pick(title,material,resp)
	  	content = resp.search("li.clearfix")
	  	title_hed = content.search("h3")
		material_master = content.search("dl.caseMate")
		material_in = material_master.search("dd")
	  	title_hed.each do |ele|
			title.push(ele.inner_text)
		end
		material_in.each do |math|
			material.push(math.inner_text)
		end
  end


  def top_search(resp) #レシピタイトル,材料
	   @next_pages = Array.new
	   @link = Array.new
	   @menu_title = Array.new					#レシピタイトル
	   @menu_material = Array.new(3){Array.new}	#材料

	   num=0
	   recipe_n=0
	   test = resp.search("div.catePopuRank")
	   test1 = test.search("li")
	   @test2 = test1.search("a")
	   for num in 0..2 do
		   @link[num] = @test2[num][:href]
		   @next_pages[num] = resp.link_with(:href => @link[num]).click
		   @menu_title[num]= @next_pages[num].search("strong")[0].text
		   @i=0	#材料の数
		   @next_pages[num].search("//li[@itemprop='ingredients']").each do |node|	
		   	@menu_material[num][@i] = @next_pages[num].search("a.name")[@i].text	#材料を配列に格納
		   	@i=@i+1
		   end
		
		end

  def top_search(resp) #未完成
	   next_pages = Array.new
	   link = Array.new
	   num = 0
	   frame = resp.search("div.catePopuRank")
	   micro_frame = frame.search("li")
	   substance  =  micro_frame.search("a")
	   for num in 0..2 do
		   link[num] = substance[num][:href]
		   next_pages[num] = resp.link_with(:href => link[num]).click
		   puts next_pages[num]
	   end

  end

end