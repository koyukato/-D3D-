require 'net/http'
require 'uri'
require 'json'
class HomesController < ApplicationController

	def index
		res = Net::HTTP.get(URI.parse('https://app.rakuten.co.jp/services/api/Recipe/CategoryList/20121121?applicationId=1012194014463186177&categoryType=medium'))

		@result = JSON.parse(res)
		#puts res.to_s
		(1..9).each do|i|
			@msg=@result['result']['medium'][i].to_s
			#@msg=result['result']['large'][0]['categoryName'].to_s
		end
	end


end
