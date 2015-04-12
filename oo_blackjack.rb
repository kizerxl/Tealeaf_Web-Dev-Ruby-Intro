#OO blackjack game 
module Blackjack
  BLACKJACK = 21
  HITMAX = 17
  HIT = 1
end 

class Player
  include Blackjack
  include Comparable 
  attr_reader :deck
  attr_accessor :hand
  
  def initialize(deck)
    @hand = []
    @deck = deck 
  end 
  
  def <=>(other)
    total = self.calculate_hand_total 
    other_total = other.calculate_hand_total
    
      if total > other_total 
        return 1 
      elsif total == other_total 
        return 0
      else 
        return -1
      end
  end 
      
  def reset_hand
    self.hand = []
  end

  def calculate_hand_total
    total = 0
    card_values = self.hand.map{ |card| card[1] }
    card_values.each do |value| 
      if value == "ACE"
        total += 11
      elsif value.to_i == 0 
        total += 10
      else 
        total += value.to_i
      end 
    end  
    #adjust for ACES
    card_values.count("ACE").times do 
      total -= 10
    end 
    total 
  end 
  
  def add_card_to_hand
    self.hand<< self.deck.draw_a_card
  end 
  
  def deal_two_cards
    puts "\nTwo cards have been dealt to #{self}"
    2.times{ add_card_to_hand}
    puts"#{self} currently has: #{display_current_hand}."
    puts"#{self}'s score is #{calculate_hand_total}\n\n"
  end 
  
  def display_current_hand
    hand_string = []
    self.hand.each do |card|
      hand_string<< "#{card[1]} of #{card[0]}"
    end 
    hand_string = hand_string.join(", ")
  end 

  def blackjack?
    calculate_hand_total == BLACKJACK 
  end 

  def bust?
    calculate_hand_total > BLACKJACK
  end 
  
  def to_s
    "#{self.name}"
  end 
end 

class Human < Player
  attr_reader :name
  def initialize(deck)
    super 
    puts "Welcome to Blackjack\n\nPlease enter your name"
    @name = gets.chomp
    puts "Let's begin #{self.name}..\n\n"
  end
  
  def hit_or_stay
      begin
        puts "\nEnter 1 to hit or 2 to stay "
        user_option = gets.to_i
        if user_option.to_i == HIT 
          add_card_to_hand
          puts"#{self} has hit.."
          puts"#{self} currently has: #{display_current_hand}."
          puts"#{self} score is #{calculate_hand_total}\n\n"
        end
      end until [2].include?(user_option) || calculate_hand_total >= BLACKJACK
   end
end 

class Computer < Player
  attr_reader :name
  def initialize(deck)
    @name = "Computer"
    super
  end 

  def hit_or_stay
    begin
      add_card_to_hand
      puts "\n#{self} has hit.."
      puts"#{self} currently has: #{display_current_hand}."  
      puts"#{self} score is #{calculate_hand_total}\n\n"
    end until calculate_hand_total >= HITMAX 
  end
  
  def display_current_hand
    hand_string = []
    self.hand.each do |card|
      if self.hand.last == card 
        hand_string<< "#{card[1]} of #{card[0]}" 
      else 
        hand_string<< "hidden card"
      end 
    end
    hand_string = hand_string.join(", ")
  end 
end 

class Deck
  attr_reader :suit, :type 
  attr_accessor :deck 
  def initialize
    @suit = ["Hearts", "Diamonds", "Clubs", "Spades"]
    @type = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "King", 
    "Queen", "Jester", "ACE"]
    @deck = suit.product(type)
  end 

  def draw_a_card
    self.deck.shuffle!.pop
  end 

  def reset_deck
    self.deck = suit.product(type)
  end 
end

class Game
  
  def initialize 
    @deck = Deck.new
    @human = Human.new(@deck)
    @computer = Computer.new(@deck)
  end 
  
  def deal_first_cards
    @human.deal_two_cards
    @computer.deal_two_cards
  end 

  def compare_hands
    if @human.calculate_hand_total == @computer.calculate_hand_total
      puts "It's a tie"
    elsif @human.calculate_hand_total > @computer.calculate_hand_total
      puts "#{@human} wins!!!"
    else 
      puts "#{@computer} wins, you lose...."
    end 
  end 

  def play_again?
    begin 
      puts "Play again ? (y/n): "
      option = gets.chomp.downcase
    end until ['y', 'n'].include?(option)
    option
  end 

  def reset_game
    @deck.reset_deck
    @human.reset_hand
    @computer.reset_hand
  end

  def display_blackjack_bust_message
    if @human.blackjack? || @computer.blackjack?
      puts "#{@human.blackjack? ? @human : @computer} hits BLACKJACK!!"
      puts "#{@human.blackjack? ? @human : @computer} WINS!!!!"
    elsif @human.bust? || @computer.bust? 
      puts "#{@human.bust? ? @human : @computer} has bust.."
      puts "#{@human} WINS!!!!"if @computer.bust?
    end 
  end 

  def blackjack_or_bust?
    @human.blackjack? || @human.bust? || @computer.blackjack? || @computer.bust?
  end 

  def start
    begin 
        deal_first_cards
        if (blackjack_or_bust?)
          display_blackjack_bust_message
        else 
          @human.hit_or_stay 
          if (blackjack_or_bust?)
            display_blackjack_bust_message
          else 
            @computer.hit_or_stay
            if (blackjack_or_bust?)
              display_blackjack_bust_message
            else
              compare_hands
            end
          end
         end
         again = play_again?
         reset_game if again == 'y'
    end until again.downcase == "n"
    puts "Thanks for playing!"
  end 
end 

Game.new.start