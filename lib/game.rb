#frozen_string_literal: true

class Game
  attr_accessor :turn_count
  attr_reader :player_one, :player_two, :grid
  
  def initialize
    @grid = Grid.new
    @player_one = Player.new
    @player_two = Player.new
    @turn_count = 0
  end

  def choose_color(number)
    colors = ['🔴', '🟡']
    player_one.color = number == 1 ? colors.shift : colors.pop
    player_two.color = colors.pop
  end

  def current_color_turn
    if player_one.color == '🔴'
      @turn_count.odd? ? '🔴' : '🟡'
    else
      @turn_count.odd? ? '🟡' : '🔴'
    end
  end

  def update_grid(color, coordinate)
    grid.update_slots(color, coordinate)
  end

  def validate_move(input)
    #player can only input 2 chars, A to G, then 1 to 6
    return input if /^[A-G]{1}[1-6]{1}$/.match?(input) 
  end

end
