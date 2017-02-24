require "spec_helper"

RSpec.describe Card do
  let(:ace_card){Card.new('A','♠')}
  let(:jack_card){Card.new('J','♦')}
  let(:five_card){Card.new('5','♥')}
  it 'should return a card object' do
    expect(five_card).to be_a_kind_of(Card)
  end
  it '#is_face_card? should return true if rank is J, Q, K, or A' do
    expect(jack_card.is_face_card?).to eq(true)
    expect(five_card.is_face_card?).to eq(false)
  end
  it '#is_not_ace? should return true if rank is not an A' do
    expect(jack_card.is_ace?).to eq(false)
    expect(five_card.is_ace?).to eq(false)
    expect(ace_card.is_ace?).to eq(true)
  end
end
