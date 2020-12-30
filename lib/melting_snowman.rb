# frozen_string_literal: true

require_relative 'game'

current_game = Game.new

p current_game.word_array
p current_game.word_display_array
puts current_game.word_display

current_game.take_turns
