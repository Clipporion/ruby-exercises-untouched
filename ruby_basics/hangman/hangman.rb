require 'yaml'
require "psych"

class Game
  def initialize
    @word = choose_word
    @hints = create_hints
    @wrongs = set_wrong_guesses
    @guessed = []
    @guess = ""
    @ended = false
  end

  attr_accessor :word, :hints, :wrongs, :guessed, :guess, :ended

  def choose_word
    word = []
    until word.length >= 5 && word.length <= 12
      word = File.readlines("wordlist.txt").sample.chomp.split("")
    end
    word
  end

  def set_wrong_guesses
    puts "How many wrong guesses do you want to make from 1 to 10?"
    wrongs = 0
    until wrongs > 0 && wrongs <= 10
      wrongs = gets.chomp.to_i
    end
    wrongs
  end

  def create_hints
    hints = []
    until hints.length == @word.length
      hints.push("_")
    end
    hints
  end

  def make_guess
    puts "Please choose a letter to check or enter 'save' to save the game"
    guess = ""
    until guess.length == 1 && ('a'..'z').include?(guess) && !@guessed.include?(guess) || guess == "save"
      guess = gets.chomp.downcase
    end
    guess
  end

  def print_field
    @hints.each do |letter|
      print "#{letter} "
    end
    puts
  end

  def check_guess
    if !@word.include?(@guess)
      @wrongs -= 1
    elsif @word.include?(@guess)
      @word.each_with_index do |letter, index|
        if letter == @guess
          @hints[index] = @guess
        end
      end
    else 
      puts 'Something went terribly wrong!!!'
    end
  end

  def print_guessed
    puts "You already guessed #{@guessed}"
  end

  def check_winner
    if @word == @hints
      puts 'Congratulations, you win!'
      true
    end
  end

  def check_loser
    if @wrongs == 0
      puts 'Sorry, you didn\'t win, the word was'
      @word.each do |letter|
        print "#{letter} "
      end
      puts
      true
    end
  end

  def play_round
    print_field
    print_guessed
    puts "You have #{@wrongs} wrong guesses left"
    @guess = make_guess
      if @guess == "save"
        save_game
        @ended = true
      else
        check_guess
        @guessed.push(@guess)
      end
  end

  def save_game
    File.open("savegame.txt","w") do |file|
      file.write(YAML.dump(self))
    end
  end

  def play_game
    until @ended
      if check_winner
        @ended = true
      elsif check_loser
        @ended = true
      else
        play_round
      end
    end
  end
end


puts "Welcome to Hangman
so you want to play a [n]ew game or [l]oad a saved game?"

input = ''
until input == 'n' || input == 'l'
  input = gets.chomp.downcase
end

case input
when "n"
  game = Game.new
  game.play_game
when "l"
  game = Psych.unsafe_load(File.read('savegame.txt'))
  game.play_game
end
