require "spec_helper"

RSpec.describe 'blackjack.rb' do
  let(:game){BlackJack.new}
  it 'ties with dealer are a loss unless its a blackjack' do
    100.times do
      game = BlackJack.new('hit')
      if game.players_hand.calculate_hand == 21 && game.dealers_hand.calculate_hand == 21
        expect(game.game_results).to eq('push')
      end
    end

  end



end
