# frozen_string_literal: true

require './helpables'

ALLOWED_NUMBERS = %w[0 1 2 3 4 5].freeze

# Handles activities that happens on the board
class MasterMind
  include Helpables

  def initialize
    @computer = Computer.new
    @player = Player.new
  end

  def set_roles
    if @player.player_as_codebreaker
      code_breaker = @player
      code_maker = @computer
    else
      code_breaker = @computer
      code_maker = @player
    end
    [code_breaker, code_maker]
  end

  def play_game
    # Both the player and computer rounds make one game session
    play_round
    play_computer_round
  end

  def play_round
    # Handles player round of guessing
    code_breaker, code_maker = set_roles

    code = code_maker.make_code
    feedback = []

    11.times do
      p code
      guess = code_breaker.make_guess(feedback)
      return puts 'Yaaay!' if winner?(code, guess)

      feedback = compare_codes(code, guess)
      show_hint(feedback)
    end
  end

  def play_computer_round
    # player switches and computer starts the guessing
    @player.switch_role
    play_round
  end

  def winner?(code, guess)
    code.join == guess.join
  end

  def show_hint(hints)
    puts "Correct digits in the right position: \u{1f600} #{hints[0]}"
    puts "Correct digits in the wrong position: \u{1f609} #{hints[1]}"
  end
end

# Handles player activities
class Player
  attr_reader :player_as_codebreaker

  def initialize
    @player_as_codebreaker = true
  end

  def make_guess(_feedback = nil)
    # we'll never need to pass feedback to this method.
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

  def switch_role
    @player_as_codebreaker = !@player_as_codebreaker
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

MasterMind.new.play_game
