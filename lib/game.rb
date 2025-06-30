require_relative "board"
class Game
  def initialize
    display()
    @board = nil
    if !@board.nil?
       play()
    end
  end

  #Generates a word from file that is greater than 5 and less than 12 letters
  def generateWord
    File.open("/Users/teo/repos/ruby_hangman/data/google-10000-english-no-swears.txt", "r") do |file|
      while true
        generated_word = file.readlines()[Random.rand(9893)].chomp.downcase
        if generated_word.length > 5 && generated_word.length < 12
          break
        end
        file.rewind
      end
      file.close
      generated_word
    end
  end

  #Menu display, goes into play loop depending on selection
  def display
    puts "Welcome to Ruby Hangman!"
    puts "To start a new game press 1"
    puts "To load a game press 2"
    puts "To exit press any other key"
    input = gets.chomp.to_i
    case input
      when 1
        @board = Board.new(generateWord)
        play()
      when 2
        @board = Board.new()
        puts "Enter the save name"
        input = gets.chomp.downcase
        @board.from_YAML(input)
        play()
      when 3
        puts "Goodbye"
    end
  end

  #Play loop
  def play
    while true
      @board.displayHangMan
      puts "Enter a letter or 1 to save and quit"
      input = gets.chomp.downcase
      if input != "1"
        @board.checkLetter(input)
        if @board.gameOver?
          @board.displayHangMan
          print "Correct word: "
          puts @board.word
          break
        end
      else
        puts "Enter a file name"
        input = gets.chomp.downcase
        @board.to_YAML(input)
        break
      end
    end
  end

end

#Initializes and runs game
game = Game.new