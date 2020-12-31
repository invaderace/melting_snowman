This is a hangman type game, but with a melting snowman instead of a hangman because anyone making hangman in 2020 is a jackass.

https://www.theodinproject.com/courses/ruby-programming/lessons/file-i-o-and-serialization-ruby-programming

Learning outcomes:
loading and using a file in the program.
saving a file state.
structuring the files in a library for easier reading.

ascii art borrowed from Joan Stark's ASCII Art Gallery (super old!), now archived here: https://asciiart.website/index.php?art=holiday/christmas/snowman

2020.12.31 - The game is finished and I'm pretty satisfied. The only rubocop issue being raised is about YAML.safe_load being preferred to YAML.load, but being that this is my first project using serialization, I'm not wasting my time on that subject as I'm sure it will come up again. The only other addition I can think to add would be to have ruby find the terminal width to center the game. Perhaps at a later date!