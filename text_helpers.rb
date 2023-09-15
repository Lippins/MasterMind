# frozen_string_literal: true

# Contains the majority of key texts for the game.
module TextHelpers
  INTRO = "

  >> Press any key to start playing. (☞⌐▀͡ ͜ʖ͡▀ )☞   Welcome to MASTERMIND!

  ---- [ HOW TO PLAY ] #{'- ' * 30}
  The AI generates a Secret Code, say '3 0 5 2' and you'll need
  to crack/guess it. You can try a few times (11 times at maximum).

  After each wrong guess you get two hints that tell you:
  1. How many correct digits you've put in the right position
  2. How many correct digits you've put in the wrong position

  ---- [ GROUND RULES ] #{'- ' * 30}
  Here are a few things to keep in mind.

  1. Length of the Secret Code:
        The Secret Codde is 4 characters
  2. Number of digits to make your Secret Code
        You can make yur Secret code using any digit between
        0 to 5 [0, 1, 2, 3, 4, 5]
  3. Number of guessing trials:
        You have 11 guesses to figure out the secret code.

  +#{'- ' * 40}+
  |#{' ' * 28}PRESS ANY KEY TO CONTINUE!  #{' ' * 25}|
  +#{'- ' * 40}+
  "

  HEADER = "

      #{'=' * 3}+#{'=' * 8}+++++#{'=' * 20}+++++#{'=' * 8}+#{'=' * 3}
      #{' ' * 20}  MASTER MIND  #{' ' * 20}
      #{'=' * 3}+#{'=' * 8}+++++#{'=' * 20}+++++#{'=' * 8}+#{'=' * 3}
      #{"\n" * 2}
      #{'- ' * 8}+ - #{'- ' * 8}+#{' -' * 8} -

        Code Length 4     6 Items [0 - 5]     Trials 11

      #{'- ' * 8}+ - #{'- ' * 8}+#{' -' * 8} -

      Get Started!
  "

  PICK_DIGIT = "
      dummy - Pick 4 digits from [0 - 5], separated by spaces:
  "

  HINT = "

     + Correct digits in the right position: \u{1f600} hint_1
     ≈ Correct digits in the wrong position: \u{1f609} hint_2
  "

  WRONG_ENTRY = "
     ✗ Wrong entry! Pick 4 digits from [0 - 5], separated by spaces:
  "
end
