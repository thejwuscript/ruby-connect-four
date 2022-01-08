# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/grid'
require_relative '../lib/player'

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
    context 'when player chooses 1' do
      let(:player_red) { instance_double(Player) }
      let(:player_yellow) { instance_double(Player) }

      it 'sends color= with red to player' do
        player_input = 1
        game.instance_variable_set(:@player_one, player_red)
        expect(player_red).to receive(:color=).with('🔴')
        game.choose_color(player_input)
      end

      it 'sends color= with yellow to the other player' do
        player_input = 1
        game.instance_variable_set(:@player_two, player_yellow)
        expect(player_yellow).to receive(:color=).with('🟡')
        game.choose_color(player_input)
      end
    end
  
  
  
  # choose who goes first.
  # heads or tails.
  end
end

  