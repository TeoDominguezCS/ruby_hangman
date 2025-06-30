require 'yaml'

class Board
  attr_reader :word, :guesses, :correct, :errors, :missing, :done
  def initialize(word = "", guesses = [], correct = [], errors = 0)
    @word = word
    @guesses = guesses
    @correct = correct
    @errors = errors
    @missing = word.length
    @done = false
  end

  # Writes current game to YAML
  def to_YAML(string)
    yaml_data = YAML.dump(self)
    File.write("./../saves/#{string}.yaml", yaml_data)
  end

  #Loads data from YAML file
  def from_YAML(string)
    data = YAML.unsafe_load_file("./../saves/#{string}.yaml")
    @word = data.word
    @guesses = data.guesses
    @correct = data.correct
    @errors = data.errors
    @missing = data.missing
    @done = data.done
  end

#Checks if game is over
  def gameOver? 
    if @errors == 6 || @done
      true
    else
      false
    end
  end

  # Checks if guessed letter is correct, and it hasnt been guessed yet
  def checkLetter(letter)
    if @word.include?(letter) && !@correct.include?(letter)
      @correct.push(letter)
    elsif @guesses.include?(letter) || @correct.include?(letter)
      puts "Letter already entered!"
    elsif !letter.match?(/^[a-zA-Z]$/)
      puts "Not a valid input"
    else
      @errors += 1
      @guesses.push(letter)
    end
  end

  #displays word with filled in correct guesses, displays all guesses
  def displayWord
    @word.each_char do |char|
      if @correct.include? char
        print " #{char} "
        @missing -= 1
      else
        print " _ "
      end
    end

    if @missing == 0
      @done == true
    else
      @missing == @word.length
    end

    puts ""
    print "Guesses: "
    puts @guesses.inspect
  end

  #Displays current hangman board
  def displayHangMan
    case @errors
    when 0
      puts "  ______"
      puts " |     "
      puts " |     "
      puts " |     "
      puts " |     "
      puts "_|____"
    when 1
      puts "  ______"
      puts " |      O"
      puts " |     "
      puts " |     "
      puts " |     "
      puts "_|____"
    when 2
      puts "  ______"
      puts " |      O"
      puts " |      |"
      puts " |     "
      puts " |     "
      puts "_|____"
    when 3
      puts "  ______"
      puts " |      O"
      puts " |     /|"
      puts " |      "
      puts " |     "
      puts "_|____"
    when 4
      puts "  ______"
      puts " |      O"
      puts " |     /|\\"
      puts " |     "
      puts " |     "
      puts "_|____"
    when 5
      puts "  ______"
      puts " |      O"
      puts " |     /|\\"
      puts " |     / "
      puts " |     "
      puts "_|____"
    when 6
      puts "  ______"
      puts " |      O"
      puts " |     /|\\"
      puts " |     / \\ "
      puts " |     "
      puts "_|____"
      puts "GAME OVER T____T"
    end
    puts ""
    displayWord()
  end
  
  
end