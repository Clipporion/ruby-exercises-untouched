require "pry-byebug"

class Mastermind
  def initialize
    @code = []
    @hints = []
    @rounds_left = 12
    @choice = []
    @game_over = false
    @possibilities = []
    @copy_code = []
    @copy_choice = []
    @mode = ""
    puts 'Welcome to Masterminda game where you have to guess a 4 digit code.'
    puts 'Each digit is between 1 and 6. After each guess you\'ll get a hint.'
    puts 'X means exact match, O means a correct number in a wrong place. you have 12 guesses'
  end

  def setup
    puts 'Do you want to be the [m]aker or the [b]reaker?'
    until @mode == "b" || @mode == "m" do
      @mode = gets.chomp.downcase
    end

    if @mode == "b"
      4.times {@code.push(rand(1..6))}
    elsif @mode == "m"
      player_choice
      @code = @choice
      (1..6).each do |a|
        (1..6).each do |b|
          (1..6).each do |c|
            (1..6).each do |d|
              @possibilities.push([a,b,c,d])
            end
          end
        end
      end
    end
  end

  def player_choice
    @choice = []
    until @choice.all?{|num| num.between?(1,6)} && @choice.length == 4 do
      puts "Please enter a 4 digit code with each digit from 1 to 6"
      input = gets.chomp.split("").map! {|num| num.to_i}
      @choice = input
    end
  end

  def computer_choice
    @choice = @possibilities.sample
    @copy_choice = @choice.map {|num| num}
    p @choice
  end

  def check_match
    @hints = []
    @copy_code = @code.map {|num| num}
    index = 0
    while index < @choice.length do
      if @choice[index] == @copy_code[index]
        @hints.push("X")
        @copy_code.delete_at(index)
        @choice.delete_at(index)
      else
       index += 1
      end
    end
  end

  def check_containing
    @choice.each do |num|
      if @copy_code.include?(num)
        @hints.push("O")
        @copy_code.slice!(@copy_code.index(num))
      end
    end
  end

  def remove_impossible
    @possibilities.delete(@copy_choice)
    @copy_code = @code.map {|num| num}
    index = 0
    while index < @possibilities.length do
      if @hints.count("X").zero? && @hints.count("O").zero?
        if @possibilities[index] == @copy_choice[index] || @possibilities[index].include?(@copy_choice[index])
          @possibilities.delete_at(index)
        else
          index += 1
        end
      elsif @hints.count("X") == 1
        if @possibilities[index][0] == @copy_choice[0] || @possibilities[index][1] == @copy_choice[1] ||
               @possibilities[index][2] == @copy_choice[2] || @possibilities[index][3] == @copy_choice[3]
               index += 1
        else
          @possibilities.delete_at(index)
        end
      elsif @hints.count("X") == 2
        if @possibilities[index][0] == @copy_choice[0] && @possibilities[index][1] == @copy_choice[1] ||
               @possibilities[index][0] == @copy_choice[0] && @possibilities[index][2] == @copy_choice[2] ||
               @possibilities[index][0] == @copy_choice[0] && @possibilities[index][3] == @copy_choice[3] ||
               @possibilities[index][1] == @copy_choice[1] && @possibilities[index][2] == @copy_choice[2] ||
               @possibilities[index][1] == @copy_choice[1] && @possibilities[index][3] == @copy_choice[3] ||
               @possibilities[index][2] == @copy_choice[2] && @possibilities[index][3] == @copy_choice[3]
               index += 1
        else
          @possibilities.delete_at(index)
        end
      elsif @hints.count("X") == 3
        if @possibilities[index][0] == @copy_choice[0] && @possibilities[index][1] == @copy_choice[1] && @possibilities[index][2] == @copy_choice[2] ||
               @possibilities[index][0] == @copy_choice[0] && @possibilities[index][1] == @copy_choice[1] && @possibilities[index][3] == @copy_choice[3] ||
               @possibilities[index][0] == @copy_choice[0] && @possibilities[index][2] == @copy_choice[2] && @possibilities[index][3] == @copy_choice[3] ||
               @possibilities[index][1] == @copy_choice[1] && @possibilities[index][2] == @copy_choice[2] && @possibilities[index][3] == @copy_choice[3]
               index += 1
        else
          @possibilities.delete_at(index)
        end
      else 
        index = @possibilities.length
      end
    end

    index = 0
    while index < @possibilities.length do
      if @hints.count("O") == 1
        if @possibilities[index].include?(@copy_choice[0]) || @possibilities[index].include?(@copy_choice[1]) ||
           @possibilities[index].include?(@copy_choice[2]) || @possibilities[index].include?(@copy_choice[3])
           index += 1
        else 
          @possibilities.delete_at(index)
        end
      elsif @hints.count("O") == 2
        if @possibilities[index].include?(@copy_choice[0]) && @possibilities[index].include?(@copy_choice[1]) ||
              @possibilities[index].include?(@copy_choice[0]) && @possibilities[index].include?(@copy_choice[2]) ||
              @possibilities[index].include?(@copy_choice[0]) && @possibilities[index].include?(@copy_choice[3]) ||
              @possibilities[index].include?(@copy_choice[1]) && @possibilities[index].include?(@copy_choice[2]) ||
              @possibilities[index].include?(@copy_choice[1]) && @possibilities[index].include?(@copy_choice[3]) ||
              @possibilities[index].include?(@copy_choice[2]) && @possibilities[index].include?(@copy_choice[3])
              index += 1
        else
          @possibilities.delete_at(index)
        end
      elsif @hints.count("O") == 3
        if @possibilities[index].include?(@copy_choice[0]) && @possibilities[index].include?(@copy_choice[1]) && @possibilities[index].include?(@copy_choice[2]) ||
              @possibilities[index].include?(@copy_choice[0]) && @possibilities[index].include?(@copy_choice[1]) && @possibilities[index].include?(@copy_choice[3]) ||
              @possibilities[index].include?(@copy_choice[0]) && @possibilities[index].include?(@copy_choice[2]) && @possibilities[index].include?(@copy_choice[3]) ||
              @possibilities[index].include?(@copy_choice[1]) && @possibilities[index].include?(@copy_choice[2]) && @possibilities[index].include?(@copy_choice[3])
              index += 1
        else
          @possibilities.delete_at(index)
        end
      else
        index = @possibilities.length
      end
    end
  end

  def human_turn
    player_choice
    check_match
    check_containing
  end

  def computer_turn
    computer_choice
    check_match
    check_containing
    remove_impossible
  end

  def play_game
    setup
    until @game_over
      case @mode
        when "b" 
          human_turn
          if @hints == ["X","X","X","X"]
            puts "Congratulations, you win. The code was #{@code}"
            @game_over = true
          elsif @rounds_left == 0
            puts "You're out of guesses, the code was #{@code}."
            @game_over = true
          else
          @rounds_left -= 1
          p @hints
          p "You have #{@rounds_left} rounds left"
          end
        when "m"
          computer_turn
          if @hints == ["X","X","X","X"]
            puts "The computer cracked the code. The code was #{@code}"
            @game_over = true
          elsif @rounds_left == 0
            puts "The computer failed to crack the code. The code was #{@code}."
            @game_over = true
          else
          @rounds_left -= 1
          p @hints
          p "The computer has #{@rounds_left} rounds left"
          end
      end
    end
  end
end

game = Mastermind.new
game.play_game
