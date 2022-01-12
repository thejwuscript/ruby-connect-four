# frozen_string_literal: true

require_relative '../lib/grid'

# rubocop:disable Metrics/BlockLength

describe Grid do
  subject(:grid) { described_class.new }

  describe '#input_to_grid_position' do
    it 'converts B3 as an argument into a two-element array' do
      player_input = 'B3'
      array = grid.input_to_grid_position(player_input)
      expect(array).to eq( [1, -3] )
    end

    it 'converts G5 as an argument into a two-element array' do
      player_input = 'G5'
      array = grid.input_to_grid_position(player_input)
      expect(array).to eq( [6, -5] )
    end
  end

  describe '#place_color_in_slot' do
    it 'place color in the specified slot' do
      color = '🔴'
      grid_position = [1, -3]
      grid.place_color_in_slot(color, grid_position)
      slot = grid.slots_layout[-3][1]
      expect(slot).to eq(color)
    end
  end

  describe '#occupied?' do
    context 'when the slot is either red or yellow' do
      subject(:occupied_grid) { described_class.new }
      
      it 'returns true' do
        player_input = 'E5'
        occupied_grid.slots_layout[-5][4] = '🔴'
        result = occupied_grid.occupied?(player_input)
        expect(result).to be true
      end
    end

    context 'when the slot is empty' do
      subject(:empty_grid) { described_class.new }
      
      it 'returns false' do
        player_input = 'F2'
        result = empty_grid.occupied?(player_input)
        expect(result).to be false
      end
    end
  end

  describe '#four_in_a_row' do
    context 'when 4 colors are in a row' do
      subject(:four_red) { described_class.new }
      
      it 'returns the color' do
        four_red.slots_layout[2][1..4] = %w[🔴 🔴 🔴 🔴]
        color = four_red.four_in_a_row
        expect(color).to eq('🔴')
      end
    end

    context 'when 4 colors are not in a row' do
      subject(:two_colors) { described_class.new }
      
      it 'returns nil' do
        two_colors.slots_layout[3][3..6] = %w[🔴 🟡 🔴 🟡]
        result = two_colors.four_in_a_row
        expect(result).to be_nil
      end
    end

    context 'when empty spaces and colors' do
      subject(:mixed) { described_class.new }
      
      it 'returns nil' do
        mixed.slots_layout[4][1..4] = ['🔴', ' ', '🟡', ' ']
        result = mixed.four_in_a_row
        expect(result).to be_nil
      end
    end
  end

  describe '#four_vertical' do
    context 'if 4 colors in a column' do
      subject(:color_column) { described_class.new }

      before do
        for i in 2..5 do
          color_column.slots_layout[i][3] = '🔴'
        end
      end
    
      it 'returns the color' do
        result = color_column.four_vertical
        expect(result).to eq('🔴')
      end
    end

    context 'if mixed colors in a column' do
      subject(:two_colors_column) { described_class.new }
      
      before do
        for i in 0..2 do
          two_colors_column.slots_layout[i][1] = '🔴'
        end
        two_colors_column.slots_layout[3][1] = '🟡'
      end
    
      it 'returns nil' do
        result = two_colors_column.four_vertical
        expect(result).to be_nil
      end
    end

    context 'if mixed spaces and colors in a column' do
      subject(:mixed_column) { described_class.new }

      before do
        mixed_column.slots_layout[3][3] = '🔴'
        mixed_column.slots_layout[4][3] = '🟡'
      end
    
      it 'returns nil' do
        result = mixed_column.four_vertical
        expect(result).to be_nil
      end
    end
  end

  describe '#four_diagonal_right' do
    context 'if there are four colors diagonally to the right' do
      subject(:reds_diagonal_right) { described_class.new }
      
      it 'returns the color' do
        for i in 0..3 do
          reds_diagonal_right.slots_layout[1+i][0+i] = '🔴'
        end
        result = reds_diagonal_right.four_diagonal_right
        expect(result).to eq('🔴')
      end
    end

    context 'if mixed colors diagonally' do
      subject(:colors_diagonal_right) { described_class.new }
      
      it 'returns nil' do
        for i in 0..2 do
          colors_diagonal_right.slots_layout[0+i][2+i] = '🔴'
        end
        colors_diagonal_right.slots_layout[3][5] = '🟡'
        result = colors_diagonal_right.four_diagonal_right
        expect(result).to be_nil
      end
    end

    context 'if mixed spaces and colors diagonally' do
      subject(:mixed_diagonal_right) { described_class.new }
      
      it 'returns nil' do
        mixed_diagonal_right.slots_layout[2][1] = '🔴'
        mixed_diagonal_right.slots_layout[4][3] = '🟡'
        result = mixed_diagonal_right.four_diagonal_right
        expect(result).to be_nil
      end
    end
  end

  describe '#four_diagonal_left' do
    context 'if there are four colors diagonally to the left' do
      subject(:reds_diagonal_left) { described_class.new }
      
      it 'returns the color' do
        for i in 0..3
          reds_diagonal_left.slots_layout[i][5-i] = '🔴'
        end
        result = reds_diagonal_left.four_diagonal_left
        expect(result).to eq('🔴')
      end
    end

    context 'if mixed colors diagonally' do
      subject(:colors_diagonal_left) { described_class.new }
      
      it 'returns nil' do
        for i in 0..2
          colors_diagonal_left.slots_layout[i][6-i] = '🔴'
        end
        colors_diagonal_left.slots_layout[3][3] = '🟡'
        result = colors_diagonal_left.four_diagonal_left
        expect(result).to be_nil 
      end
    end

    context 'if mixed spaces and colors diagonally' do
      subject(:mixed_diagonal_left) { described_class.new }
      
      it 'returns nil' do
        mixed_diagonal_left.slots_layout[1][6] = '🔴'
        mixed_diagonal_left.slots_layout[3][4] = '🟡'
        result = mixed_diagonal_left.four_diagonal_left
        expect(result).to be_nil
      end
    end
  end
end
