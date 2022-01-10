#frozen_string_literal: true

class Grid

  LETTERS = %w[A B C D E F G]
  
  def initialize
  end

  def update_slots(color, coordinate)
  end

  def occupied?(coordinate)
  end

  def input_to_grid_position(coordinate)
    y_coordinate = LETTERS.index( coordinate[0] )
    x_coordinate = -coordinate[1].to_i
    grid_position = [x_coordinate, y_coordinate]
  end

end
