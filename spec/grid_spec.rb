# frozen_string_literal: true

require_relative '../lib/grid'

describe Grid do
  subject(:grid) { described_class.new }
  
  #describe '#update_slots' do
  #  it 'updates grid with given coordinate and color' do
  #    color = '🔴'
  #    coordinate = 'B3'
  #    grid.update_slots(color, coordinate)
  #    updated = @grid_nested_array[-3][1]
  #    expect(updated).to eq('🔴')
  #  end  
  #end

  describe '#input_to_grid_position' do
    it 'converts player input as an argument into a two-element array' do
      input = 'B3'
      array = grid.input_to_grid_position(input)
      expect(array).to eq( [-3, 1] )
    end
  end


end
