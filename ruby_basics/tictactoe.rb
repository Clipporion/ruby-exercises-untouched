class Player
  @@symbols = ["X","O"]
  @@number_of_players = 1
  def initialize
    puts "Player #{@@number_of_players}, enter your name:"
    @name = gets.chomp
    @@number_of_players += 1
    if @@symbols.length > 1
      puts 'Please choose X or O as your symbol'
      input = ''
      until input == @@symbols[0] || input == @@symbols[1]
      input = gets.chomp
      end
      @symbol = input
      @@symbols.delete(input)
    else
      @symbol = @@symbols[0]
    end
  end

  def self.reset
    @@symbols = ["X", "O"]
    @@number_of_players = 1
  end

  attr_reader :symbol, :name
end

class Game
  def initialize(player1,player2)
    @player1 = player1
    @player2 = player2
    @fields = [1,2,3,4,5,6,7,8,9]
    @winning_lines = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
    @turn = 0
    @ended = false
    @winner = nil
  end

  def render_display
    puts " #{@fields[0]} | #{@fields[1]} | #{@fields[2]}"
    puts "---+---+---"
    puts " #{@fields[3]} | #{@fields[4]} | #{@fields[5]}"
    puts "---+---+---"
    puts " #{@fields[6]} | #{@fields[7]} | #{@fields[8]}"
  end

  def choose_field(player)
    input = 10
    until @fields.include?(input)
      puts "#{player.name} choose a field:"
      input = gets.chomp.to_i
    end
    @fields.map! do |number|
      number == input ? player.symbol : number
    end
    @winning_lines.map do |line|
      line.map! do |number|
        number == input ? player.symbol : number
      end
    end
  end

  def check_winner
    @winning_lines.each do |line|
      if line.all?(@player1.symbol)
        @ended = true
        @winner = @player1.name
      elsif
        line.all?(@player2.symbol)
        @ended = true
        @winner = @player2.name
      end
    end
  end

  def play
    render_display
    until @ended == true || @fields.all? {|element| element.is_a?(String)}
      if @turn == 0
        choose_field(@player1)
        @turn = 1
      else
        choose_field(@player2)
        @turn = 0
      end
      render_display

      check_winner
      if @winner
        puts "The winner is #{@winner}. Congratulations!"
      elsif @fields.all? {|element| element.is_a?(String)}
        puts "Noone won, this is a draw"
      end
    end
  end
end


player1 = Player.new
player2 = Player.new

game = Game.new(player1,player2)
game.play
