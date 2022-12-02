class Viking
  def initialize(name)
    @name = name
    @age = rand(22..30)
    @health = rand(100..120)
    @strength = rand(8..10)
    print "#{@name} is #{@age} years old, has #{@health} health points and an "
    puts "attack strength of #{@strength}"
  end

  attr_reader :name, :age, :strength, :health

  def attack(enemy)
    attack_value = (self.strength*10*rand(1..3)/10).floor
    enemy.health = enemy.health -= attack_value
    print "#{self.name} attacked #{enemy.name} and he lost #{attack_value} health points "
    puts "#{enemy.name} now has #{enemy.health} health points."
  end

  def take_potion
    self.health += 20
    puts "You healed up 20 health points and now have #{self.health}"
  end

  def play_round(enemy)
    puts "#{self.name},do you want to [a]ttack or [t]ake a potion?"
    input = gets.chomp
    case input 
    when "a"
      attack(enemy)
      if enemy.health <= 0
        puts "#{enemy.name} was killed."
        puts "#{name} won the battle."
      end
    when "t"
      take_potion
    else
      play_round(enemy)
    end
  end

  protected

  attr_writer :health
end

oleg = Viking.new("Oleg")
lars = Viking.new("Lars")

turn = 0
while lars.health.positive? && oleg.health.positive?
  if turn.zero?
    oleg.play_round(lars)
    turn = 1
  else
    lars.play_round(oleg)
    turn = 0
  end
end

