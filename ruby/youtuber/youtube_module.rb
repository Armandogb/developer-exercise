require 'json'
require 'net/http'
require 'uri'

class Youtuber

	attr_reader :links ,:user_link

	def initialize
		@links = []
		@user_link = "https://www.youtube.com/watch?v="
	end
	
	def fetch_search(search_query)
		path = URI.parse(create_path(search_query))
		results = Net::HTTP.get_response(path)

		create_links(results.body)
	end

	def create_links(results_json)
		@links = []

		vids = JSON.parse(results_json, symbolize_names: true)[:items]
		vid_id = vids.map { |vid| vid[:id][:videoId] }

		vid_id.each { |id| @links << (@user_link + id)}

	end

	def create_path(search_query)
		"https://www.googleapis.com/youtube/v3/search?part=snippet&q="+ search_query +"&type=video&maxResults=3&key=AIzaSyARfNmPqYgY-VlFAZT8VqPbowEYgWYaUps"
	end

	def show_results
		@links.map { |video| video.to_s }
	end

end

