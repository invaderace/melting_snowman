class Menu
  def start_game
    puts new_or_save
    answer = gets.chomp
    if answer == '1'
      Game.new
    elsif answer == '2'
      filename = 'save/savegame.yaml'
      save_file = File.open(filename, 'r')
      savegame = YAML::load(save_file)
      save_file.close
      savegame
    else
      puts invalid_answer
      start_game
    end
  end

  def invalid_answer
    "Sorry, please enter '1' or '2'."
  end

  def new_or_save
    'New game (1) or saved game (2)?'
  end
end