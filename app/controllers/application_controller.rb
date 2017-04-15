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

  def top_search(resp) #未完成
	   ranks = Array.new
	   test = resp.search("div.cateRankTtl")
	   test.each do |val|
		   puts val.inner_text
		   ranks.push(val.inner_text)
	   end
  end

end
