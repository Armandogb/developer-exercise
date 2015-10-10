require 'json'
require 'net/http'
require 'uri'

class Youtuber

	attr_reader :links
	
	def initialize
		@links = []
	end

	def fetch_search(search_query)
		path = URI.parse(create_path(search_query))
		results = Net::HTTP.get_response(path)
	end

	def create_path(search_query)
		"https://www.googleapis.com/youtube/v3/search?part=snippet&q=#"+ search_query +"&type=video&maxResults=3&key=AIzaSyCfNToBTIWfhNj2f_nsUhohjWPnBhoyXnw"
	end

end

