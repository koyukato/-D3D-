require 'net/http'
require 'uri'
require 'json'
class HomesController < ApplicationController

def index
	res = Net::HTTP.get(URI.parse('https://app.rakuten.co.jp/services/api/Recipe/CategoryList/20121121?applicationId=1012194014463186177&categoryType=medium'))

	@result = JSON.parse(res)
end

def search
	
end

def sample
	require 'nokogiri'
	require 'open-uri'
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
