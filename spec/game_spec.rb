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

  describe '#assign_color' do
    let(:player_red) { instance_double(Player) }
    let(:player_yellow) { instance_double(Player) }
    
    context 'when player chooses 1' do
      it 'sends color= with red to player_one' do
        player_input = 1
        game.instance_variable_set(:@player_one, player_red)
        expect(player_red).to receive(:color=).with('🔴')
        game.assign_color(player_input)
      end

      it 'sends color= with yellow to player_two' do
        player_input = 1
        game.instance_variable_set(:@player_two, player_yellow)
        expect(player_yellow).to receive(:color=).with('🟡')
        game.assign_color(player_input)
      end
    end

    context 'when player chooses 2' do
      it 'sends color= with yellow to player_one' do
        player_input = 2
        game.instance_variable_set(:@player_one, player_yellow)
        expect(player_yellow).to receive(:color=).with('🟡')
        game.assign_color(player_input)
      end

      it 'sends color= with red to player_two' do
        player_input = 2
        game.instance_variable_set(:@player_two, player_red)
        expect(player_red).to receive(:color=).with('🔴')
        game.assign_color(player_input)
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
    context 'when given a letter corresponding to a column' do
      context 'when the column is not full' do
        input = 'C'
        before do
          game.instance_variable_set(:@grid, temp = Grid.new)
          for i in 3..5
            temp.slots_layout[i][2] = '🔴'
          end
        end
        it 'returns a valid coordinate' do
          result = game.validate_move(input)
          expect(result).to eq('C4')
        end
      end

      context 'when the column is full' do
        input = 'C'
        before do
          game.instance_variable_set(:@grid, temp = Grid.new)
          for i in 0..5
            temp.slots_layout[i][2] = '🔴'
          end
        end
        it 'returns nil' do
          result = game.validate_move(input)
          expect(result).to be_nil
        end
      end
    end

    context 'when given any string not coorresponding to a column' do
      input = 'P'
      before do
        game.instance_variable_set(:@grid, temp = Grid.new)
      end
      it 'returns nil' do
        result = game.validate_move(input)
        expect(result).to be_nil
      end
    end
  end

  describe '#player_move' do
    before do
      prompt = 'Please enter a letter.'
      allow(game).to receive(:puts).with(prompt).once
    end
  
    context 'when player enters a valid move' do
      before do
        valid_input = 'D'
        allow(game).to receive(:gets).and_return(valid_input)
      end
    
      it 'stops loop and does not display error message' do
        error_message = "Invalid entry. Please try again."
        expect(game).not_to receive(:puts).with(error_message)
        game.player_move
      end
    end

    context 'when player enters an invalid move once then a valid move' do
      before do
        symbols = '@%'
        valid = 'B'
        allow(game).to receive(:gets).and_return(symbols, valid)
      end
    
      it 'completes loop and displays error message once' do
        error_message = "Invalid entry. Please try again."
        expect(game).to receive(:puts).with(error_message).once
        game.player_move
      end
    end
  
    context 'when player enters invalid move twice then a valid move' do
      before do
        symbols = '@!'
        letters = 'ip'
        valid = 'E'
        allow(game).to receive(:gets).and_return(symbols, letters, valid)
      end
    
      it 'completes loop and displays error message twice' do
        error_message = "Invalid entry. Please try again."
        expect(game).to receive(:puts).with(error_message).twice
        game.player_move
      end
    end
  end

  describe '#choose_color' do
    context 'when player inputs 1 or 2' do   
      before do
        prompt = "Choose your color. Enter '1' for red or '2' for yellow."
        allow(game).to receive(:puts).with(prompt)
      end
    
      it 'returns 1' do
        input = '1'
        allow(game).to receive(:gets).and_return(input)
        result = game.choose_color
        expect(result).to eql(1)
      end

      it 'returns 2' do
        input = '2'
        allow(game).to receive(:gets).and_return(input)
        result = game.choose_color
        expect(result).to eql(2)
      end
    end

    context 'when player entry is invalid once' do
      before do
        three = '3'
        two = '2'
        allow(game).to receive(:gets).and_return(three, two)
        prompt = "Choose your color. Enter '1' for red or '2' for yellow."
        allow(game).to receive(:puts).with(prompt).once
      end
    
      it 'completes loop and displays error message once' do
        error_message = "Invalid entry. Please enter '1' or '2'."
        expect(game).to receive(:puts).with(error_message).once
        game.choose_color
      end
    end
  end

  describe '#game_over?' do
    let(:judge_grid) { instance_double(Grid) }

    before do
      allow(judge_grid).to receive(:four_in_a_row)
      allow(judge_grid).to receive(:four_vertical)
      allow(judge_grid).to receive(:four_diagonal)
    end
      
    
    context 'when red has 4 in a row' do
      it 'returns true' do
        game.instance_variable_set(:@grid, judge_grid)
        allow(judge_grid).to receive(:four_in_a_row).and_return('🔴')
        expect(game).to be_game_over
      end
    end

    context 'when yellow has 4 in a column' do
      it 'returns true' do
        game.instance_variable_set(:@grid, judge_grid)
        allow(judge_grid).to receive(:four_vertical).and_return('🟡')
        expect(game).to be_game_over
      end
    end

    context 'when yellow has 4 in a diagonal' do
      it 'returns true' do
        game.instance_variable_set(:@grid, judge_grid)
        allow(judge_grid).to receive(:four_diagonal).and_return('🟡')
        expect(game).to be_game_over
      end
    end

    context 'when no one has 4 in a row, vertically, diagonally' do
      it 'returns nil' do
        game.instance_variable_set(:@grid, judge_grid)
        expect(game).not_to be_game_over
      end
    end
  end
      
      
end

  