require_relative "card"
require_relative "deck"
require_relative "hand"
require 'pry'

class BlackJack
  attr_reader :players_hand, :dealers_hand, :terminal_output
  attr_accessor :hit_stand

  WELCOME = "
  Welcome to Black Jack!\n
  House rules:\n
  1. Dealer wins ties unless ties are blackjacks\n
  2. Dealer will hit until score of at least 17 is reached\n\n"

  def initialize
    @hit_stand = nil
    @game_deck = Deck.new
    @players_hand = Hand.new(@game_deck.draw(2))
    @dealers_hand = Hand.new(@game_deck.draw(2))
    @terminal_output = ""
    main
  end

  def main
    print WELCOME
    while @players_hand.calculate_hand <= 21 && !['s', 'stand'].include?(@hit_stand)
      if ['s', 'stand'].include?(@hit_stand)
        end_game
      elsif ['h', 'hit'].include?(@hit_stand)
        hit
      end

      player
      #&& @players_hand.calculate_hand <= 21
      while @players_hand.calculate_hand <= 21 && !['s','h','stand','hit'].include?(@hit_stand)
        user_input
      end
    end
   end_game
  end

  def game_results
    if @players_hand.calculate_hand > 21
      add_terminal_output("\nplayer bust, dealer won")
    elsif @players_hand.calculate_hand > @dealers_hand.calculate_hand
      add_terminal_output("\nplayer won")
    elsif @dealers_hand.calculate_hand > 21
      add_terminal_output("\ndealer bust, player won")
    elsif @players_hand.calculate_hand < @dealers_hand.calculate_hand
      add_terminal_output("\ndealer won")
    elsif @players_hand.calculate_hand == 21 && @dealers_hand.calculate_hand == 21
      add_terminal_output('push')
      'push'
    else
      # a tie will occur with less than blackjack, dealer always wins!
      add_terminal_output("\ndealer won")
    end
  end

  def user_input
    print @terminal_output
    print "\nDo you want to hit or stand? > "
    @hit_stand = gets.chomp.downcase
  end

  def hit
    @hit_stand = nil
    @players_hand.cards += @game_deck.draw
  end

  def player
    @terminal_output = ""
    add_terminal_output("Player was dealt: ")
    @players_hand.cards.map do |card|
      add_terminal_output(card.rank+card.suit + " ")
    end
    add_terminal_output("/ Player's score: #{@players_hand.calculate_hand}\n")
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

  def add_terminal_output(input)
    @terminal_output += input
    nil
  end

  def end_game
    dealer
    game_results
    print @terminal_output
  end
end
