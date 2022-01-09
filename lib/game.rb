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
    if number == 1
      player_one.color = '🔴'
      player_two.color = '🟡'
    elsif number == 2
      player_one.color = '🟡'
      player_two.color = '🔴'
    end
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
