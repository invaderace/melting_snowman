require_relative 'displayable'

class Menu
  include Displayable

  def start_game
    display_menu
    display_text(new_or_save)
    answer = gets.chomp
    if answer == '1'
      Game.new
    elsif answer == '2'
      load
    else
      start_game
    end
  end

  # not sure if will use this.
  def invalid_answer
    "Sorry, please enter '1' or '2'."
  end

  def load
    filename = 'save/savegame.yaml'
    save_file = File.open(filename, 'r')
    savegame = YAML::load(save_file)
    save_file.close
    savegame
  end

  def new_or_save
    'New game (1) or saved game (2)?'
  end
end