class Card
  attr_accessor :suite, :name, :value

  def initialize(suite, name, value)
    @suite, @name, @value = suite, name, value
  end
end

class Deck
  attr_accessor :playable_cards
  SUITES = [:hearts, :diamonds, :spades, :clubs]
  NAME_VALUES = {
    :two   => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => 10,
    :queen => 10,
    :king  => 10,
    :ace   => [11, 1]}

  def initialize
    shuffle
  end

  def deal_card
    random = rand(@playable_cards.size)
    @playable_cards.delete_at(random)
  end

  def shuffle
    @playable_cards = []
    SUITES.each do |suite|
      NAME_VALUES.each do |name, value|
        @playable_cards << Card.new(suite, name, value)
      end
    end
  end
end

class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def view_player_hand
    @cards.map { |card| "#{card.name} of #{card.suite}" }.join(' - ')
  end

  def starting_dealer_hand
    "#{cards[1].name} of #{cards[1].suite} - XX of XXXX"
  end

  def dealer_show_hand
    @cards.map { |card| "#{card.name} of #{card.suite}" }.join(' - ')
  end

  def hand_total
    total = @cards.map { |c| c.name == :ace ? c.value[0] : c.value }.inject(:+) 

    if total > 21
      @cards.map do |c|
        if c.name == :ace
          total -= 10
        end
      end
    end
    total
  end

end

class BjackGame

  attr_accessor :player, :dealer, :deck

  attr_reader :game_over

  def initialize
    @deck = Deck.new
    @player = Hand.new
    @dealer = Hand.new
    @game_over = false
    
    deal_hands
    check_blackjack
  end

  def deal_hands
    2.times do 
      @player.cards << @deck.deal_card
      @dealer.cards << @deck.deal_card
    end
  end

  def player_hit
    @player.cards << @deck.deal_card
    puts "Player hits!"
    
    if @player.hand_total == 21
      player_stand
    else
      check_bust
    end
  end

  def player_stand
    puts "Player stands!"
    dealer_check
  end

  def dealer_check   
    if @dealer.hand_total < 17 
      dealer_hit
      dealer_check
    else 
      dealer_stand
    end
  end

  def dealer_hit
    @dealer.cards << @deck.deal_card
  end

  def dealer_stand
    if @dealer.hand_total > 21
      check_bust
    elsif @dealer.hand_total == @player.hand_total
      puts "Push!"
    elsif @dealer.hand_total > @player.hand_total
      puts "dealer wins! #{@dealer.hand_total}"
    else
      puts "you win! #{@player.hand_total}" 
    end
    @game_over = true
    self.board 
  end


  def player_move(action)
    case action
      when "h"
        self.player_hit
      when "s"
        self.player_stand
    end 

  end


  def check_blackjack
    if @player.hand_total == 21 && @dealer.hand_total == 21
      puts "push!!"
      @game_over = true
      self.board
    elsif @dealer.hand_total == 21
      puts "dealer wins"
      @game_over = true
      self.board
    elsif @player.hand_total == 21
      puts "player wins"
      @game_over = true
      self.board
    end
  end

  def check_bust
    if @player.hand_total > 21 
      puts "you busted! #{@player.hand_total}" 
      @game_over = true
      self.board
    elsif @dealer.hand_total > 21
      puts "dealer busts! #{@dealer.hand_total}"
      @game_over = true
      self.board
    end
  end

  def board
    if @game_over
      puts ""
      puts "Dealer:"
      puts @dealer.dealer_show_hand
      puts "Dealer Total #{@dealer.hand_total}"
      puts "****************************"
      puts "****************************"
    else
      puts""
      puts "Dealer:"
      puts @dealer.starting_dealer_hand
      puts "****************************"
      puts "****************************" 
    end

      puts @player.view_player_hand  
      puts "Player Total #{@player.hand_total}"
      puts "___________________________________"

  end

end