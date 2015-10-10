require_relative 'blackjack'


x = BjackGame.new

puts "Let's get ready to gamble!!!!"

until x.game_over  

	x.board

	puts "Your Move! (enter h -hit- or s -stand-)"

	action = gets.chomp

	x.player_move(action)

end