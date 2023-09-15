# frozen_string_literal: true

require './helpables'

# Handles player activities
class Player
  include Helpables
  attr_reader :player_as_codebreaker

  def initialize
    @player_as_codebreaker = true
  end

  def make_guess(_feedback = nil)
    # we'll never need to pass feedback to this method.
    show_text(:pick_digit)
    make_code
  end

  def make_code
    code = gets.chomp.split
    unless code.all? { |digit| ALLOWED_NUMBERS.include?(digit) } && code.length == 4
      show_text(:wrong_entry)
      make_code
    end
    code
  end

  def switch_role
    sleep 1
    show_text(:role_switch_note)
    @player_as_codebreaker = !@player_as_codebreaker
  end
end
