# frozen_string_literal: true

require './master_mind'

loop do
  game = MasterMind.new
  game.play_game

  break unless game.replay?
end
