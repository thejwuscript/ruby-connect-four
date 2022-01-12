#frozen_string_literal: true

class Grid
  attr_accessor :slots_layout
  LETTERS = %w[A B C D E F G]
  
  def initialize
    @slots_layout = Array.new(6) { Array.new(7, '  ') }
  end

  def update_slots(color, coordinate)
    position = input_to_grid_position(coordinate)
    place_color_in_slot(color, position)
  end

  def occupied?(input)
    array = input_to_grid_position(input)
    x = array[0]
    y = array[1]
    slots_layout[y][x] != '  ' ? true : false
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
                      \e[1mCONNECT \e[31m4\e[0m\e[22m

        |----+----+----+----+----+----+----|
        | #{@slots_layout[-6].join(' | ')} |
        |----+----+----+----+----+----+----|
        | #{@slots_layout[-5].join(' | ')} |
        |----+----+----+----+----+----+----| 
        | #{@slots_layout[-4].join(' | ')} |
        |----+----+----+----+----+----+----|
        | #{@slots_layout[-3].join(' | ')} |
        |----+----+----+----+----+----+----|
        | #{@slots_layout[-2].join(' | ')} |
        |----+----+----+----+----+----+----|
        | #{@slots_layout[-1].join(' | ')} |
        |----+----+----+----+----+----+----|
           A    B    C    D    E    F    G  
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
    nil
  end

  def four_diagonal
    start_positions = [[2,0], [1,0], [0,0], [0,1], [0,2], [0,3]]
    start_positions.each do |elem|
      return check_diagonal(elem) if check_diagonal(elem)
    end
    nil
  end

  def check_diagonal(element)
    ary = []
    for i in 0..6
      a,b = element
      a = a + i
      b = b + i
      next if a > 5 || b > 6
      ary << slots_layout[a][b]
    end
    ary.each_cons(4) {|a| return a[0] if a.all?('🔴') || a.all?('🟡') }
  end

end
