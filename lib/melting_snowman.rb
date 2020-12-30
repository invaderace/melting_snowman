# frozen_string_literal: true

require_relative 'game'
require_relative 'menu'

current_game = Menu.new.start_game
current_game.take_turns
