# frozen_string_literal: true

# Hosts helper functions for the game
module Helpables
  def compare_codes(winning_code, guess_code)
    full_match = 0
    partial_match = 0
    winning_digit_counts = Hash.new(0)
    winning_code.each { |digit| winning_digit_counts[digit] += 1 }
    winning_code.each_with_index do |digit, index|
      if guess_code[index] == digit
        full_match += 1
      elsif winning_digit_counts[guess_code[index]].positive?
        partial_match += 1
        winning_digit_counts[guess_code[index]] -= 1
      end
    end
    [full_match, partial_match]
  end
end

ALLOWED_NUMBERS = %w[0 1 2 3 4 5].freeze

# Handles activities that happens on the board
class MasterMind
  include Helpables

  def initialize
    @computer = Computer.new
    @player = Player.new
  end

  def play
    winning_code = @player.make_code
    feedback = []

    11.times do
      p winning_code
      guess_code = @computer.make_guess(feedback)
      return puts 'Yaaay!' if winner?(winning_code, guess_code)

      feedback = compare_codes(winning_code, guess_code)
      show_hint(feedback)
    end
  end

  def winner?(winning_code, guess_code)
    winning_code.join == guess_code.join
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
  include Helpables

  def initialize
    @previous_guesses = []
    @remaining_possibilities = generate_all_possible_codes
  end

  def make_guess(feedback)
    guess = if @previous_guesses.empty?
              # Random initial guess
              generate_random_guess
            else
              refine_guess(feedback)
            end
    @previous_guesses << guess
    puts "Computer guess: #{guess}"
    guess
  end

  def make_code
    generate_random_guess
  end

  def generate_random_guess
    ALLOWED_NUMBERS.sample(4)
  end

  def generate_all_possible_codes
    ALLOWED_NUMBERS.repeated_permutation(4).map(&:join)
  end

  def refine_guess(feedback)
    # We can implement a difficulty setting here
    # Computer makes a random sub-optimal guess about 80% of the time
    return @remaining_possibilities.sample.split('') if rand < 0.8

    @remaining_possibilities = @remaining_possibilities.select do |code|
      compare_codes(code.split(''), @previous_guesses.last) == feedback
    end
    @remaining_possibilities.first.split('')
  end
end

MasterMind.new.play
