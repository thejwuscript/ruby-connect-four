# frozen_string_literal: true

require_relative '../lib/grid'

describe Grid do
  subject(:grid) { described_class.new }
  
  #describe '#update_slots' do
  #  it 'updates grid with given coordinate and color' do
  #    color = '🔴'
  #    coordinate = 'B3'
  #    grid_position = [-3, 1]
  #    allow(grid).to receive(:input_to_grid_position).with(coordinate).and_return([grid_position)
  #    grid.update_slots(color, coordinate)
  #    updated = @slots_layout[-3][1]
  #    expect(updated).to eq('🔴')
  #  end  
  #end

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

  describe '#four_in_a_row?' do

end
