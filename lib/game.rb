require_relative "board"
class Game
  def initialize
    display()
    @board = nil
    if !@board.nil?
       play()
    end
  end

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
        puts "Load"
      when 3
        puts "Goodbye"
    end
  end

  def play
    while true
      @board.displayHangMan
      puts "Enter a letter"
      input = gets.chomp.downcase
      @board.checkLetter(input)
      if @board.gameOver?
        @board.displayHangMan
        print "Correct word: "
        puts @board.word
        break
      end
    end
  end

end

game = Game.new