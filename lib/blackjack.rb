require_relative "card"
require_relative "deck"
require_relative "hand"

class BlackJack
  attr_accessor :hit_stand
  attr_reader :players_hand, :dealers_hand

  def initialize(hit_stand = nil)
    @hit_stand = hit_stand
    @game_deck = Deck.new
    @players_hand = Hand.new(@game_deck.draw(2))
    @dealers_hand = Hand.new(@game_deck.draw(2))
    puts "Welcome to Black Jack!"
    puts
    puts "House rules:"
    puts "1. Dealer wins ties unless ties are blackjacks"
    puts "2. Dealer will hit until score of at least 17 is reached"
    puts
    while @players_hand.calculate_hand <= 21 && !['s', 'stand'].include?(@hit_stand)
      if ['s', 'stand'].include?(@hit_stand)
        stand
      elsif ['h', 'hit'].include?(@hit_stand)
        hit
      end
      print "Player was dealt: "
      @players_hand.cards.map {|card| print card.rank+card.suit + " "}
      puts "\nPlayer's score: #{@players_hand.calculate_hand}"
      puts
      @hit_stand = nil
      while @players_hand.calculate_hand <= 21 && !['s','h','stand','hit'].include?(@hit_stand)
        print "Do you want to hit or stand? > "
        @hit_stand = gets.chomp.downcase
      end
    end
    stand
  end
  def game_results
    if @players_hand.calculate_hand > @dealers_hand.calculate_hand
      if @players_hand.calculate_hand > 21
        puts "Player busts"
        puts "Dealer Won!"
      else
        puts "Player Won!"
      end
    elsif @players_hand.calculate_hand == 21 && @dealers_hand.calculate_hand == 21
      puts "Push, no winner!"
      'push'
    else
      if @dealers_hand.calculate_hand > 21
        puts "Dealer busts"
        puts "Player Won!"
      else
        puts "Dealer Won!"
      end
    end
  end

  def stand
    dealer
    game_results
  end

  def hit
    @players_hand.cards += @game_deck.draw
  end

  def dealer
    while @dealers_hand.calculate_hand < 17
      @dealers_hand.cards += @game_deck.draw
    end
    print "Dealer was dealt: "
    @dealers_hand.cards.map {|card| print card.rank+card.suit + " "}
    puts "\nDealer's score: #{@dealers_hand.calculate_hand}"
    @dealers_hand
  end

  def print_results

  end
end
game_one = BlackJack.new
game_one
