# frozen_string_literal: true

require './helpables'

# Handles computer activities
class Computer
  include Helpables

  def initialize
    @previous_guesses = []
    @remaining_possibilities = generate_all_possible_codes
  end

  def make_guess(feedback)
    guess = if @previous_guesses.empty?
              # Random initial guess
              show_text(:thinking_ai)
              sleep 3
              generate_random_guess
            else
              refine_guess(feedback)
            end
    @previous_guesses << guess
    puts "Computer guess: #{format_code(guess)}"
    guess
  end

  def make_code
    generate_random_guess
  end

  def generate_random_guess
    # 50% chance that the AI's guess will contain a duplicate number
    if rand < 0.5
      ALLOWED_NUMBERS.sample(4)
    else
      4.times.map { ALLOWED_NUMBERS.sample }
    end
  end

  def generate_all_possible_codes
    ALLOWED_NUMBERS.repeated_permutation(4).map(&:join)
  end

  def refine_guess(feedback)
    # We can implement a difficulty setting here
    # Computer makes a random sub-optimal guess about 80% of the time
    show_text(:thinking_ai)
    sleep rand(3..6)
    return @remaining_possibilities.sample.split('') if rand < 0.55

    @remaining_possibilities = @remaining_possibilities.select do |code|
      compare_codes(code.split(''), @previous_guesses.last) == feedback
    end
    @remaining_possibilities.first.split('')
  end
end
