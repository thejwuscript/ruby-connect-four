# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/grid'

# rubocop:disable Metrics/BlockLength

describe Game do
  describe '#initialize' do
    subject(:create_game) { described_class.new }
    
    it 'instantiates class Grid' do
      expect(Grid).to receive(:new)
      create_game
    end
  
  # choose who goes first.
  # heads or tails.
  end
end

  