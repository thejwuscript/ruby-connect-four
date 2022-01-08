# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/grid'

# rubocop:disable Metrics/BlockLength

describe Game do
  subject(:game) { described_class.new }
  
  describe '#initialize' do
    it 'instantiates class Grid' do
      expect(Grid).to receive(:new)
      game
    end
  end

  describe '#choose_color' do
    context 'when argument is 1' do
      it 'assigns red to player' do
        game.choose_color
        color = game.player.color
        expect(color).to eq('🔴')
      end

      it 'assigns yellow to CPU' do
        game.choose_color
        color = game.computer.color
        expect(color).to eq('🟡')
      end
    end
  
  
  
  # choose who goes first.
  # heads or tails.
  end
end

  