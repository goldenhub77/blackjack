require "spec_helper"

RSpec.describe Deck do
  let(:random_deck){Deck.new}
  let(:sorted_deck_of_cards){random_deck.cards.sort_by {|card| [card.rank, card.suit]}}
  it 'should return and array of Card objects' do
    expect(random_deck).to be_a_kind_of(Deck)
  end
  it 'array must contain 52 unique Card objects' do
    expect(random_deck.cards.uniq.size).to eq(52)
  end
  it 'array order must be randomized' do
    sorted_first_card = sorted_deck_of_cards.first.rank + sorted_deck_of_cards.first.suit
    sorted_last_card = sorted_deck_of_cards.last.rank + sorted_deck_of_cards.last.suit
    expect(sorted_deck_of_cards).to_not eq(random_deck.cards)
    expect(sorted_first_card).to eq('10♠')
    expect(sorted_last_card).to eq('Q♦')
  end
  it '#draw must return (X) number of Cards from the top of the deck and remove from array' do
    expect(random_deck.draw(2)).to be_a_kind_of(Array)
    expect(random_deck.draw(2).size).to eq(2)
    expect(random_deck.cards.size).to eq(48)
  end
  it 'if no argument is passed to #draw it should draw 1 Card' do
    expect(random_deck.draw.size).to eq(1)
    expect(random_deck.cards.size).to eq(51)
  end
end
