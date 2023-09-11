# frozen_string_literal: true

ALLOWED_NUMBERS = %w[1 2 3 4 5 6].freeze

# Handles activities that happens on the board
class GameBoard
end

# Handles player activities
class Player
  def guess_code
    make_code
  end

  def make_code
    code = gets.chomp.split
    unless code.all? { |digit| ALLOWED_NUMBERS.include?(digit) }
      puts 'Wrong entry! Pick four digits from [0 - 5], separated by spaces:'
      make_code
    end
    code
  end
end

# Handles computer activities
class Computer
  # 4.times.map{ALLOWED_NUMBERS.sample}
  def make_code
    ALLOWED_NUMBERS.sample(4)
  end
end

Player.new.make_code
