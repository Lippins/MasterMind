# frozen_string_literal: true

ALLOWED_NUMBERS = %w[0 1 2 3 4 5].freeze

# Handles activities that happens on the board
class MasterMind
  def initialize
    @computer = Computer.new
    @player = Player.new
    play
  end

  def play
    winning_code = @computer.make_code
    p winning_code
    guess_code = @player.guess_code
    return puts "player wins! He guessed the code #{winning_code}" if winner?(winning_code, guess_code)

    show_hint(compare_codes(winning_code, guess_code))
  end

  def winner?(winning_code, guess_code)
    # Checks if the winning code and guess codes match
    winning_code.join == guess_code.join
  end

  def compare_codes(winning_code, guess_code)
    # Checks for a full or partial match between winning code and guess code
    full_match =  0
    partial_match = 0
    winning_code.each_with_index do |w_digit, w_index|
      guess_code.each_with_index do |g_digit, g_index|
        full_match += 1 if (w_digit == g_digit) && (w_index == g_index)
        partial_match += 1 if (w_digit == g_digit) && (w_index != g_index)
      end
    end
    [full_match, partial_match]
  end

  def show_hint(hints)
    puts "Correct digits in the right position: \u{1f600} #{hints[0]}"
    puts "Correct digits in the wrong position: \u{1f609} #{hints[1]}"
  end
end

# Handles player activities
class Player
  def guess_code
    make_code
  end

  def make_code
    code = gets.chomp.split
    unless code.all? { |digit| ALLOWED_NUMBERS.include?(digit) } && code.length == 4
      puts 'Wrong entry! Pick 4 digits from [0 - 5], separated by spaces:'
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

MasterMind.new
