#frozen_string_literal: true

class Game
  attr_reader :player_one, :player_two
  def initialize
    @grid = Grid.new
    @player_one = Player.new
    @player_two = Player.new
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

  def set_first_player
    ['🔴','🟡'].sample
  end


end
