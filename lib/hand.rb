require_relative 'card'
require_relative 'deck'
class Hand
  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end
  
  def calculate_hand
    score = 0
    @cards.each do |card|
      if card.is_face_card?
        if card.is_ace?
          score += 1
        end
        score += 10
      else
        rank = card.rank.to_i
        score += rank
      end
    end
    @cards.each do |card|
      if card.is_ace?
        score > 21 ? (score -= 10) : score
      end
    end
    score
  end
end
