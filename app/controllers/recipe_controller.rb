class RecipeController < ApplicationController
  def index
    @version = '1.0'
    @date = DateTime.now.strftime('%Y-%m-%d %H-%M')
  end

  # 画面1 - 食べたい料理の条件を決定
  def search

  end

  # 画面2 - 検索結果のレシピをリストで公開
  def list

  end

  # 画面3 - 選択されたレシピの詳細を表示
  def detail

  end
end
