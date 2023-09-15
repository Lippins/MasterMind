# frozen_string_literal: true

require './text_helpers'

# Hosts helper functions for the game
module Helpables
  TEXTS = {
    intro: TextHelpers::INTRO,
    header: TextHelpers::HEADER,
    pick_dight: TextHelpers::PICK_DIGIT,
    hint: TextHelpers::HINT,
    wrong_entry: TextHelpers::WRONG_ENTRY,
    win: TextHelpers::WIN,
    loss: TextHelpers::LOSS,
    replay: TextHelpers::REPLAY,
    thanks: TextHelpers::THANKS
  }.freeze

  def compare_codes(code, guess)
    full_match = 0
    partial_match = 0
    winning_digit_counts = Hash.new(0)
    code.each { |digit| winning_digit_counts[digit] += 1 }
    code.each_with_index do |digit, index|
      if guess[index] == digit
        full_match += 1
      elsif winning_digit_counts[guess[index]].positive?
        partial_match += 1
        winning_digit_counts[guess[index]] -= 1
      end
    end
    [full_match, partial_match]
  end

  def replay?
    puts TEXTS[:replay]
    answer = gets.chomp.downcase
    return true if %w[y yes].include?(answer)

    puts TEXTS[:thanks]
  end

  def update_text(text_name, text_string, replacement_string)
    TEXTS[text_name].sub(text_string, replacement_string)
  end

  def show_text(text_name)
    puts TEXTS[text_name]
  end

  def format_code(array)
    return_string = '['
    array.each { |item| return_string += " #{item}" }
    return_string += ' ]'
  end
end

# puts Helpables.update_text(:hint, 'hint_1', 'tested')
