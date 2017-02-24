require_relative "card"
require_relative "deck"
require_relative "hand"

class BlackJack
  attr_accessor :hit_stand
  attr_reader :players_hand, :dealers_hand

  WELCOME = "
  Welcome to Black Jack!\n
  House rules:\n
  1. Dealer wins ties unless ties are blackjacks\n
  2. Dealer will hit until score of at least 17 is reached\n\n"

  def initialize(hit_stand = nil)
    @hit_stand = hit_stand
    @game_deck = Deck.new
    @players_hand = Hand.new(@game_deck.draw(2))
    @dealers_hand = Hand.new(@game_deck.draw(2))
    @terminal_output = ""

    main
  end

  def add_terminal_output(input)
    if @terminal_output.include?(input)
      @terminal_output = ""
    else
      @terminal_output += input
    end
    nil
  end

  def main
    print WELCOME
    while @players_hand.calculate_hand <= 21 && !['s', 'stand'].include?(@hit_stand)

      if ['s', 'stand'].include?(@hit_stand)
        end_game
      elsif ['h', 'hit'].include?(@hit_stand)
        hit
      end

      add_terminal_output("Player was dealt: ")
      @players_hand.cards.map {|card| add_terminal_output(card.rank+card.suit + " ")}
      add_terminal_output("/ Player's score: #{@players_hand.calculate_hand}\n")
      @hit_stand = nil

      while !['s','h','stand','hit'].include?(@hit_stand) && @players_hand.calculate_hand < 21
        print @terminal_output
        print "\nDo you want to hit or stand? > "
        @hit_stand = gets.chomp.downcase
      end
    end
   end_game
  end

  def game_results
    if @players_hand.calculate_hand > @dealers_hand.calculate_hand
      @players_hand.calculate_hand > 21 ? (add_terminal_output("\nplayer bust")) : (add_terminal_output("\nplayer won"))
    elsif @players_hand.calculate_hand < @dealers_hand.calculate_hand
      @dealers_hand.calculate_hand > 21 ? (add_terminal_output("\ndealer bust, player won")) : (add_terminal_output("\ndealer won"))
    elsif @players_hand.calculate_hand == 21 && @dealers_hand.calculate_hand == 21
      add_terminal_output('push')
      'push'
    else
      # a tie will occur with less than blackjack, dealer always wins!
      add_terminal_output("\ndealer won")
    end
  end

  def hit
    @players_hand.cards += @game_deck.draw
  end

  def dealer
    # if there were more players playing against the dealer you will need this logic
    # && @players_hand.calculate_hand <= 21
    while @dealers_hand.calculate_hand < 17
      @dealers_hand.cards += @game_deck.draw
    end
    add_terminal_output("Dealer was dealt: ")
    @dealers_hand.cards.map {|card| add_terminal_output(card.rank+card.suit + " ")}
    add_terminal_output("/ Dealer's score: #{@dealers_hand.calculate_hand}")
    @dealers_hand
  end

  def end_game
    dealer
    game_results
    puts @terminal_output
  end
end
game_one = BlackJack.new
game_one
