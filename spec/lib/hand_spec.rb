require "spec_helper"

RSpec.describe Hand do
  let(:deck){Deck.new}
  let(:cards){deck.draw(2)}
  let(:hand){Hand.new(cards)}
  it 'must be a Hand object' do
    expect(hand).to be_a_kind_of(Hand)
  end
  it 'hand must be unique' do
    expect(hand.cards.uniq.size).to eq(hand.cards.size)
  end
  it 'must return top two cards of deck' do
    expect(deck.cards.last).to eq(hand.cards.last)
  end
  it '#calculate_hand must return hand ranks added together as integer' do
    expect(hand.calculate_hand).to be_a_kind_of(Integer)

      #  100.times do
      #    count = 0
      #    deck = Deck.new
      #    cards = deck.draw(2)
      #    cards += deck.draw(2)
      #    hand = Hand.new(cards)
      #    hand.cards.each do |card|
      #      if card.is_ace?
       #
      #        count += 1
      #      end
      #    end
      #    if count >= 1
      #      puts hand.cards.inspect
      #      puts hand.calculate_hand
      #    end
      #  end

      hand_20 = Hand.new([
        Card.new('10', '♦'),
        Card.new('J', '♥')
      ])
      hand_blackjack = Hand.new([
        Card.new('A', '♦'),
        Card.new('J', '♥')
      ])
      hand_ace = Hand.new([
        Card.new('A', '♦'),
        Card.new('7', '♥')
      ])
      another_hand = Hand.new([
        Card.new('4', '♦'),
        Card.new('8', '♥')
      ])
    expect(hand_20.calculate_hand).to eq(20)
    expect(hand_blackjack.calculate_hand).to eq(21)
    expect(hand_ace.calculate_hand).to eq(18)
    expect(another_hand.calculate_hand).to eq(12)

  end
end
