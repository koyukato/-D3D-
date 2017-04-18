class RecipeController < ApplicationController
require 'net/http'
require 'uri'
require 'json'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'date'

  def index
    @version = '1.0'
    @date = DateTime.now.strftime('%Y-%m-%d %H-%M')

  end

  # 画面1 - 食べたい料理の条件を決定
  def search
  end	

  # 画面2 - 検索結果のレシピをリストで公開
  def list

	puts @word=params[:name].to_s
	url=URI.escape('https://recipe.rakuten.co.jp/search/'+@word+'/')
	charset=nil
	html=open(url) do |f|
	charset=f.charset
	f.read
	end
	doc=Nokogiri::HTML.parse(html,charset)
	#タイトル
	doc.css('//div[class="cateResultTitBox"]').each do |node|
		@title=node.css('h2[class="cateResultTit"]').inner_text
	end
	#上位20件の取得
	@menu=Array.new
	doc.css('//div[data-ratunit="item"]').each do |node|
		for num in 1..3 do
			doc.css('//a[rank="'+num.to_s+'"]').each do |node|
				@menu[num]=node.css('div[class="cateRankTtl"]').inner_text
			end
		end			
	end
	doc.css('//li[class="clearfix"]').each do |node|
		for num in 4..20 do
			doc.css('//a[rank="'+num.to_s+'"]').each do |node|
				@menu[num]=node.css('h3').inner_text
				end
		end
	end
  	if params[:name]  != nil
		puts @word=params[:name].to_s
		url=URI.escape('https://recipe.rakuten.co.jp/search/'+@word+'/')
		charset=nil
		html=open(url) do |f|
		charset=f.charset
		f.read
		end
		doc=Nokogiri::HTML.parse(html,charset)
		#タイトル
		doc.css('//div[class="cateResultTitBox"]').each do |node|
			@title=node.css('h2[class="cateResultTit"]').inner_text
		end
		#上位20件の取得
		@menu=Array.new
		doc.css('//div[data-ratunit="item"]').each do |node|
			for num in 1..3 do
				doc.css('//a[rank="'+num.to_s+'"]').each do |node|
					@menu[num]=node.css('div[class="cateRankTtl"]').inner_text
				end
			end			
		end
		doc.css('//li[class="clearfix"]').each do |node|
			for num in 4..20 do
				doc.css('//a[rank="'+num.to_s+'"]').each do |node|
					@menu[num]=node.css('h3').inner_text
				end
			end
		end
	elsif params[:cost] != nil && params[:time] != nil
		ntime = Time.now
		t = ntime.hour.to_i
		# params[:cost] #cost = 2:300    cost = 3:500 
		# params[:time] # time 1:5分 time 2:10分　time 3:15分　time 4;30

		if t >= 4 && t <= 10
			word = "夕飯"
			search_mecha(word,params[:cost],params[:time])
		elsif t > 10 && t <= 14 #昼
			word = "夕飯"
			search_mecha(word,params[:cost],params[:time])
		elsif  t > 14 && t <= 15 #おやつ
			word = "夕飯"
			search_mecha(word,params[:cost],params[:time])
		elsif t > 15 && t <=  23 #夕飯
			word = "夕飯"
			search_mecha(word,params[:cost],params[:time])
		elsif t >= 0 && t < 4 #夕飯
			word = "夕飯"
			search_mecha(word,params[:cost],params[:time])
		end
	end


	# res = Net::HTTP.get(URI.parse('https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20121121?applicationId=1012194014463186177&'))
	# puts @result = JSON.parse(res)

    render :list, layout: "list"
  end

  # 画面3 - 選択されたレシピの詳細を表示
  def detail
    id= params[:id]
    puts 	url = 'https://recipe.rakuten.co.jp/recipe/'+id
    charset = nil
    html = open(url) do |f|
      charset = f.charset # 文字種別を取得
      f.read # htmlを読み込んで変数htmlに渡す
    end

    # ノコギリを使ってhtmlを解析
    doc = Nokogiri::HTML.parse(html, charset)	

    #タイトル
    doc.css('//span[itemprop="title"]').each do |node|
      @title=node.css('strong').inner_text
    end

    #所要時間
    doc.css('//div[class=outlineMemo]').each do |node|
      @incTime=node.css('time').inner_text
    end

    #価格
    doc.css('//div[class=outlineMemo]').each do |node|
      @incMoney=node.css('li[class=icnMoney]').inner_text
    end
    #メニュー		
    ingredients=[]
    hash = {}
    doc.css('//li[itemprop="ingredients"]').each do |node|
      hash = {
        "Name":node.css('a').inner_text,
        "Amount":node.css('p').inner_text
      }
      ingredients.push(hash)
    end
    @ingredients=ingredients

    #工程数
    @step=1;
    doc.css('//li[class="stepBox"]').each do |node|
      @step=@step+1
    end
  end
end