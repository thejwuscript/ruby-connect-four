#frozen_string_literal: true

class Grid
  attr_accessor :slots_layout
  LETTERS = %w[A B C D E F G]
  
  def initialize
    @slots_layout = Array.new(6) { Array.new(7, ' ') }
  end

  def update_slots(color, coordinate)
  end

  def occupied?(coordinate)
  end

  def input_to_grid_position(coordinate)
    x_coordinate = LETTERS.index( coordinate[0] )
    y_coordinate = -coordinate[1].to_i
    grid_position = [x_coordinate, y_coordinate]
  end

  def place_color_in_slot(color, coordinate)
    x = coordinate[0]
    y = coordinate[1]
    self.slots_layout[y][x] = color
  end

end
