#frozen_string_literal: true

class Grid
  attr_accessor :slots_layout
  LETTERS = %w[A B C D E F G]
  
  def initialize
    @slots_layout = Array.new(6) { Array.new(7, ' ') }
  end

  def update_slots(color, coordinate)
    position = input_to_grid_position(coordinate)
    place_color_in_slot(color, position)
  end

  def occupied?(input)
    array = input_to_grid_position(input)
    x = array[0]
    y = array[1]
    slots_layout[y][x] != ' ' ? true : false
  end

  def input_to_grid_position(coordinate)
    x_coordinate = LETTERS.index( coordinate[0] )
    y_coordinate = -coordinate[1].to_i
    grid_position = [x_coordinate, y_coordinate]
  end

  def place_color_in_slot(color, grid_position)
    x = grid_position[0]
    y = grid_position[1]
    self.slots_layout[y][x] = color
  end

  def show_grid
    puts <<~HEREDOC

         |---+---+---+---+---+---+---|
      6  | #{@slots_layout[-6].join(' | ')} |
         |---+---+---+---+---+---+---|
      5  | #{@slots_layout[-5].join(' | ')} |
         |---+---+---+---+---+---+---| 
      4  | #{@slots_layout[-4].join(' | ')} |
         |---+---+---+---+---+---+---|
      3  | #{@slots_layout[-3].join(' | ')} |
         |---+---+---+---+---+---+---|
      2  | #{@slots_layout[-2].join(' | ')} |
         |---+---+---+---+---+---+---|
      1  | #{@slots_layout[-1].join(' | ')} |
         |---+---+---+---+---+---+---|
           A   B   C   D   E   F   G  
    HEREDOC
  end

  def four_in_a_row
    slots_layout.each do |row|
      4.times do |i|
        return row[i] if row[i..i+3].all?('🔴')
        return row[i] if row[i..i+3].all?('🟡')
      end
    end
    nil
  end

  def four_vertical
    for i in 0..6 do
      temp = [] 
      for j in 0..5 do
        temp << slots_layout[j][i]
      end
    temp.each_cons(4) {|a| return a[0] if a.all?('🔴') || a.all?('🟡') }
    end
  end

end
