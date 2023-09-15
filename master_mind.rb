# frozen_string_literal: true

require './helpables'
require './computer'
require './player'

ALLOWED_NUMBERS = %w[0 1 2 3 4 5].freeze

# Handles activities that happens on the board
class MasterMind
  include Helpables

  def initialize
    @computer = Computer.new
    @player = Player.new
    show_text(:intro)
    sleep 2
    show_text(:header)
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

  def play_round(who = 'You')
    # Handles player round of guessing
    code_breaker, code_maker = set_roles

    code = code_maker.make_code
    feedback = []

    11.times do |i|
      puts "ATTEMPTS LEFT ➠ ➜ #{11 - i} "
      guess = code_breaker.make_guess(feedback)
      return display_win_status(:win, code, who) if winner?(code, guess)

      feedback = compare_codes(code, guess)
      show_hint(feedback)
    end
    display_win_status(:loss, code, who)
  end

  def play_computer_round
    # player switches and computer starts the guessing
    @player.switch_role
    sleep 2
    show_text(:code_maker_note)
    play_round('Computer')
  end

  def display_win_status(status_key, code, who)
    text = update_text(status_key, 'dummy', who)
    text = text.sub('cracked_code', format_code(code))
    puts text
  end

  def winner?(code, guess)
    code.join == guess.join
  end

  def show_hint(hints)
    text = update_text(:hint, 'hint_1', hints[0].to_s)
    text = text.sub('hint_2', hints[1].to_s)
    puts text
  end
end
