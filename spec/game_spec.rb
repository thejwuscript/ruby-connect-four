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
    let(:player_red) { instance_double(Player) }
    let(:player_yellow) { instance_double(Player) }
    
    context 'when player chooses 1' do
      it 'sends color= with red to player_one' do
        player_input = 1
        game.instance_variable_set(:@player_one, player_red)
        expect(player_red).to receive(:color=).with('🔴')
        game.choose_color(player_input)
      end

      it 'sends color= with yellow to player_two' do
        player_input = 1
        game.instance_variable_set(:@player_two, player_yellow)
        expect(player_yellow).to receive(:color=).with('🟡')
        game.choose_color(player_input)
      end
    end

    context 'when player chooses 2' do
      it 'sends color= with yellow to player_one' do
        player_input = 2
        game.instance_variable_set(:@player_one, player_yellow)
        expect(player_yellow).to receive(:color=).with('🟡')
        game.choose_color(player_input)
      end

      it 'sends color= with red to player_two' do
        player_input = 2
        game.instance_variable_set(:@player_two, player_red)
        expect(player_red).to receive(:color=).with('🔴')
        game.choose_color(player_input)
      end
    end
  end

  describe '#current_color_turn' do
    context 'if player_one is red' do
      let(:player_one_red) { instance_double(Player, color: '🔴') }
      
      before do
        game.instance_variable_set(:@player_one, player_one_red)
      end
      
      it 'returns red on turn 1' do
        game.turn_count = 1
        result = game.current_color_turn
        expect(result).to eq('🔴')
      end

      it 'returns yellow on turn 2' do
        game.turn_count = 2
        result = game.current_color_turn
        expect(result).to eq('🟡')
      end

      it 'returns red on turn 9' do
        game.turn_count = 9
        result = game.current_color_turn
        expect(result).to eq('🔴')
      end

      it 'returns yellow on turn 10' do
        game.turn_count = 10
        result = game.current_color_turn
        expect(result).to eq('🟡')
      end
    end

    context 'if player_one is yellow' do
      let(:player_one_yellow) { instance_double(Player, color: '🟡' ) }

      before do
        game.instance_variable_set(:@player_one, player_one_yellow)
      end
      
      it 'returns yellow on turn 1' do
        game.turn_count = 1
        result = game.current_color_turn
        expect(result).to eq('🟡')
      end

      it 'returns red on turn 2' do
        game.turn_count = 2
        result = game.current_color_turn
        expect(result).to eq('🔴')
      end

      it 'returns yellow on turn 7' do
        game.turn_count = 7
        result = game.current_color_turn
        expect(result).to eq('🟡')
      end

      it 'returns red on turn 8' do
        game.turn_count = 8
        result = game.current_color_turn
        expect(result).to eq('🔴')
      end
    end
  end

  describe '#update_grid' do
    let(:grid_update) { instance_double(Grid) }

    before do
      game.instance_variable_set(:@grid, grid_update)
    end

    context "if red picks a valid coordinate to play" do
      it 'sends update_slots to grid with color and coordinate info' do
        color = '🔴'
        coordinate = 'B3'
        expect(grid_update).to receive(:update_slots).with(color, coordinate)
        game.update_grid(color, coordinate)
      end
    end
  end

  describe '#validate_move' do
    context 'when given a valid input as an argument' do
      it 'returns the input' do
        input = 'C4'
        result = game.validate_move(input)
        expect(result).to eq('C4')
      end
    end

    context 'when given two letters as argument' do
      it 'returns nil' do
        two_letters = 'MM'
        result = game.validate_move(two_letters)
        expect(result).to be_nil
      end
    end

    context 'when given two digits as argument' do
      it 'returns nil' do
        two_digits = '24'
        result = game.validate_move(two_digits)
        expect(result).to be_nil
      end
    end

    context 'when given three or more characters as argument' do
      it 'returns nil' do
        three_letters = 'A2B'
        result = game.validate_move(three_letters)
        expect(result).to be_nil
      end
    end

    context 'when given 1 character as an argument' do
      it 'returns nil' do
        one_letter = 'F'
        result = game.validate_move(one_letter)
        expect(result).to be_nil
      end
    end
  end

  describe '#player_move' do
    context 'when user enters a valid move' do
      it 'stops loop and does not display error message' do
      end
    end

    context 'when user enters an invalid move once then a valid move' do
      it 'completes loop and displays error message once' do
      end
    end
  
    context 'when user enters invalid move twice then a valid move' do
      it 'completes loop and displays error message twice' do
      end
    end
  end
      
end

  