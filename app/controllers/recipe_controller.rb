class RecipeController < ApplicationController
  def index
    @version = '1.0'
    @date = DateTime.now.strftime('%Y-%m-%d %H-%M')
  end

  # 画面1 - 食べたい料理の条件を決定
  def search
    require 'net/http'
    require 'uri'
    require 'json'

    res = Net::HTTP.get(URI.parse('https://app.rakuten.co.jp/services/api/Recipe/CategoryList/20121121?applicationId=1012194014463186177&categoryType=medium'))

    @result = JSON.parse(res)
  end

  # 画面2 - 検索結果のレシピをリストで公開
  def list

  end

  # 画面3 - 選択されたレシピの詳細を表示
  def detail
    require 'nokogiri'
    require 'open-uri'

    url = 'https://recipe.rakuten.co.jp/recipe/1500006337/'

    charset = nil
    html = open(url) do |f|
      charset = f.charset # 文字種別を取得
      f.read # htmlを読み込んで変数htmlに渡す
    end

    # ノコギリを使ってhtmlを解析
    doc = Nokogiri::HTML.parse(html, charset) 
    # site title

    #タイトル
    @title=doc.css('//meta[property="og:title"]/@content').to_s

    #メニュー   
    ingredients=[]
    hash = {}
    doc.css('//li[itemprop="ingredients"]').each do |node|
      hash = {
        "name":node.css('a').inner_text,
        "amount":node.css('p').inner_text
      }
      ingredients.push(hash)
    end
    @ingredients=ingredients
  end
end
