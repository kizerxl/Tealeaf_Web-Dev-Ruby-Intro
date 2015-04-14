# OO version of Paper, Rock, Scissors 
# There are 2 players: a human and the computer. Each take seperate turns 
# and draw paper, rock or scissors
# Player or computer can win, lose or tie. At the end of a round, a prompt 
# to play again is given
# R = Rock, P = Paper , S = Scissors 
# R > S, P < R 
# S > P, R < S 
# P > R, S < P 
# player and human can draw (select R, P or S)

class Hand 
  include Comparable
  attr_accessor :value

  def initialize(value)
    @value = value 
  end 

  def <=> (other_hand)
    if value == other_hand.value
      0
    elsif ( (value == "R" && other_hand.value == "S") || 
      (value == "P" && other_hand.value == "R")|| 
      (value == "S" && other_hand.value == "P") )
      1
    else 
      -1
    end 
  end 

  def print_winning_message
    if value == "P"
      puts "Paper defeats Rock"
    elsif value == "R"
      puts "Rock smashed Scissors"
    elsif value == "S"
      puts "Scissors just a cut a new one in paper"
    end 
  end 

  def to_s
    GameEngine::CHOICES[value]
  end 
end 

class Player 
  attr_accessor :name, :hand
  def initialize(name)
    @name = name
  end

  def to_s 
    "#{name} plays #{hand}"
  end 
end 

class Human < Player
  def initialize(name="User")
    super
  end

  def play
    begin 
      puts "Please select R for Rock, P for Paper and S for Scissors"
      choice = gets.chomp.upcase 
    end until GameEngine::CHOICES.keys.include?(choice)
    @hand = Hand.new(choice)
  end 
end 

class Computer < Player
  def initialize(name="Computer") 
    super(name)
  end 

  def play 
    self.hand = Hand.new(GameEngine::CHOICES.keys.sample)
  end 
end 

class GameEngine 
  CHOICES = {"R" => "Rock", "P" => "Paper", "S" => "Scissors"}
  attr_accessor :human, :computer
  def initialize
    @human = Human.new
    @computer = Computer.new
  end 

  def get_winner
    puts "#{human.name} has played #{human.hand}"
    puts "#{computer.name} has played #{computer.hand}"
    if human.hand == computer.hand 
      puts "Its a tie!"
    elsif human.hand > computer.hand 
      human.hand.print_winning_message 
      puts "#{human.name} WINS!"
    else
      computer.hand.print_winning_message
      puts "#{human.name} loses..."
    end
  end 

  def play_again?
    begin
    puts "\nPlay again(y/n):"
    again = gets.chomp.upcase 
    end until ['Y', 'N'].include? again 
    again
  end 

  def start
    puts "Let's play Paper, Rock, Scissors"
    puts "What is your name?"
    human.name = gets.chomp
    begin 
      human.play 
      computer.play 
      get_winner
      again = play_again?
    end while again == 'Y'
  end 
end  

GameEngine.new.start

