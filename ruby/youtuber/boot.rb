require_relative 'youtube_module'

Yt = Youtuber.new

puts "What do you want to search on Youtube for?"

puts "Search......"

search_query = gets.chomp

Yt.fetch_search(search_query)

puts "Here are your top 3 results!"
puts Yt.show_results

