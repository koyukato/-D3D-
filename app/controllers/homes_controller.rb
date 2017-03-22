require 'net/http'
require 'uri'
require 'json'
class HomesController < ApplicationController

	def index
		res = Net::HTTP.get(URI.parse('https://app.rakuten.co.jp/services/api/Recipe/CategoryList/20121121?applicationId=1012194014463186177&categoryType=medium'))

		@result = JSON.parse(res)
	end


end
