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
    it 'Takes two arguments, use them to find the correct nested array index and place color there' do
      color = '🔴'
      grid_position = [1, -3]
      grid.place_color_in_slot(color, grid_position)
      slot = grid.slots_layout[-3][1]
      expect(slot).to eq(color)
    end
  
  end

    

end
