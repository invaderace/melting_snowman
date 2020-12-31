# frozen_string_literal: true

require_relative 'displayable'

# Holds instructions to start the game and chooses between new and saved game.
class Menu
  include Displayable

  # Menu shows the snowman and asks if they want new or saved game.
  def start_game
    display_menu
    answer = gets.chomp
    check(answer)
  end

  def check(answer)
    if answer == '1'
      Game.new
    elsif answer == '2'
      load
    else
      start_game
    end
  end

  def display_menu
    display_refresh
    display_snowman(snowman_ten)
    display_text(new_or_save)
  end

  def load
    filename = 'save/savegame.yaml'
    save_file = File.open(filename, 'r')
    savegame = YAML.load(save_file)
    save_file.close
    savegame
  end

  def new_or_save
    'New game (1) or saved game (2)?'
  end
end
