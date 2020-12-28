class Dictionary
  def initialize
    @dictionary_file = "5desk.txt"
    @dictionary = File.readlines @dictionary_file
  end

  def total_words
    @dictionary.index(@dictionary[-1])
  end

  def rand_word
    rand_index = rand(total_words + 1)
    @dictionary.each_with_index do |word, index|
      if index == rand_index
        return word
      end
    end
  end
end
