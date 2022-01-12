#frozen_string_literal: true

class Game
  attr_accessor :turn_count
  attr_reader :player_one, :player_two, :grid
  LETTERS = %w[A B C D E F G]
  
  def initialize
    @grid = Grid.new
    @player_one = Player.new
    @player_two = Player.new
    @turn_count = 0
  end

  def play_game
    assign_color(choose_color)
    grid.show_grid
    round
    game_end
  end

  def round
    loop do
      @turn_count += 1
      move = player_move
      update_grid(current_color_turn, move)
      grid.show_grid
      return if game_over?
    end
  end

  def game_over?
    return true if grid.four_in_a_row
    return true if grid.four_vertical
    return true if grid.four_diagonal
    return true if turn_count == 42
  end
  
  def choose_color
    puts "Choose your color. Enter '1' for red or '2' for yellow."
    loop do
      input = gets.chomp
      return input.to_i if /^[1-2]{1}$/.match?(input)

      puts "Invalid entry. Please enter '1' or '2'."
    end
  end


  def assign_color(number)
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
    return nil unless /^[A-G]{1}$/.match?(input)
    
    column = LETTERS.index(input)
    -1.downto(-6) do |i|
      next unless grid.slots_layout[i][column] == ' '
      
      return "#{input}#{-i}"
    end
    nil
  end

  def player_move
    puts 'Please enter a letter.'
    loop do
      input = gets.chomp.upcase
      coordinate = validate_move(input)
      return coordinate if coordinate

      puts "Invalid entry. Please try again."
    end
  end

  def game_end
    if color = grid.four_in_a_row || grid.four_vertical || grid.four_diagonal
      puts "Congrats, #{color} wins the game!"
    elsif turn_count == 42
      puts "It's a draw!"
    end
    play_again?
  end

  def play_again?
    puts "Play again? (y/n)"
    input = gets.chomp.downcase
    if input == 'y'
      Game.new.play_game
    else
      puts "Thanks for playing."
    end
  end

end
