# frozen_string_literal: true

require './text_helpers'

# Hosts helper functions for the game
module Helpables
  TEXTS = {
    intro: TextHelpers::INTRO,
    header: TextHelpers::HEADER,
    pick_digit: TextHelpers::PICK_DIGIT,
    hint: TextHelpers::HINT,
    wrong_entry: TextHelpers::WRONG_ENTRY,
    win: TextHelpers::WIN,
    loss: TextHelpers::LOSS,
    replay: TextHelpers::REPLAY,
    thanks: TextHelpers::THANKS,
    thinking_ai: TextHelpers::THINKING_AI,
    role_switch_note: TextHelpers::ROLE_SWITCH_NOTE,
    code_maker_note: TextHelpers::CODE_MAKER_NOTE
  }.freeze

  def compare_codes(code, guess)
    full_match, unmatched_digits = check_full_match(code, guess)
    partial_match = check_partial_match(unmatched_digits.first, unmatched_digits.last)
    [full_match, partial_match]
  end

  def check_full_match(code, guess)
    # Checks the two arrays for a full match. Also returns the digits for partial matching
    full_match = 0
    # Store code and guess unmatched digits in an array for later matching
    unmatched_digits = [code.map(&:clone), guess.map(&:clone)]
    code.each_with_index do |digit, index|
      next unless guess[index] == digit

      full_match += 1
      # leave empty spaces in unmatched digits
      unmatched_digits.first[index] = nil
      unmatched_digits.last[index] = nil
    end
    [full_match, unmatched_digits.map(&:compact)]
  end

  def check_partial_match(code, guess)
    partial_match = 0
    code_digit_counts = Hash.new(0)
    code.each { |digit| code_digit_counts[digit] += 1 }

    guess.each do |digit|
      next unless code_digit_counts[digit].positive?

      partial_match += 1
      code_digit_counts[digit] -= 1
    end
    partial_match
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
