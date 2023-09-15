# Hosts helper functions for the game
module Helpables
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
end
