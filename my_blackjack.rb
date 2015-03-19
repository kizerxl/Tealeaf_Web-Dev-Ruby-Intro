#Blackjack 
#Tealeaf Academy 

suits = ["Hearts", "Diamonds", "Spades", "Clubs"]
cards = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "ACE", "KING", "QUEEN", "JESTER"]

user_hand = []
dealer_hand = []

#make deck of cards and shuffle 
deck = suits.product(cards)
deck.shuffle! 

#calulates score for respective hand 
def calculate_score(hand_of_cards)
  arr = hand_of_cards.map{|e| e[1]}
  total = 0 
  arr.each do |card| 
    if card == "ACE"
      total+= 11
    elsif card.to_i == 0 #For suits ie Jester, Queen
      total+= 10
    else 
      total+= card.to_i
    end
  end 

  #adjust for Aces
  arr.select{|card| card == "ACE"}.count.times do 
    total-=10 if total > 21
  end 
  total
end 

#format cards 
def format_card(entry)
  format = entry[1] +" of "+ entry[0]
end 

def start_game (user_hand, dealer_hand, deck)
  2.times do 
    user_hand<< deck.pop 
    dealer_hand<< deck.pop 
  end 
end 

def insert_blank_line
  puts ""
end 

def outputcards(hand_of_cards)
  card_list = []
  hand_of_cards.each do |card| 
    card_list<< format_card(card)
  end 
  card_list = card_list.join(", ")
end 

#Our game 

puts "What is your name?"
name = gets.chomp
insert_blank_line
puts "Let's play #{name}"
insert_blank_line
start_game(user_hand, dealer_hand, deck)
insert_blank_line

user_total = calculate_score(user_hand)
dealer_total = calculate_score(dealer_hand)

puts "#{name} has #{outputcards(user_hand)} with a total of #{user_total}"
puts "Dealer has #{outputcards(dealer_hand)} with a total of #{dealer_total}"
insert_blank_line

if user_total == 21 
  puts "#{name} hit blackjack! #{name} wins!!!"
  insert_blank_line
  exit 
end 

#User turn 
while user_total < 21 
  puts "#{name}, enter 1 to hit or 2 to stay:"
  choice = gets.chomp 

  if !['1','2'].include?(choice)
    next
  end 

  if choice == '1'
    puts "#{name} has chosen to hit"
    user_hand<< deck.pop
    user_total = calculate_score(user_hand)
    puts "#{name} has the following cards: #{outputcards(user_hand)}"
    puts "with a total of #{user_total}"
  end

  if user_total == 21 
    puts "#{name} hit blackjack! #{name} wins!!!"
    insert_blank_line
    exit 
  elsif user_total > 21 
    puts "#{name} has busted. Dealer wins, you lose..."
    insert_blank_line
    exit 
  end 

  if choice == "2"
    puts "#{name} has chosen to stay"
    insert_blank_line
    break
  end 

end 

#Dealer turn 

if dealer_total == 21
  puts "Dealer has hit blackjack. #{name} has lost.."
  insert_blank_line
  exit
end 

while dealer_total < 17 

  #keep hitting 
  dealer_hand<<deck.pop 
  dealer_total = calculate_score(dealer_hand)
  puts "Dealer has #{outputcards(dealer_hand)} with a total of #{dealer_total}"
  insert_blank_line


  if dealer_total == 21
  puts "Dealer has hit blackjack. #{name} has lost.."
  insert_blank_line
  exit
  elsif dealer_total > 21
    puts "Dealer has busted. #{name} wins!"
    insert_blank_line
    exit
  end

end 

#Compare hands 
user_total = calculate_score(user_hand)
dealer_total = calculate_score(dealer_hand)
puts "#{name} has #{outputcards(user_hand)} with a total of #{user_total}"
puts "Dealer has #{outputcards(dealer_hand)} with a total of #{dealer_total}"

if user_total > dealer_total 
  puts "#{name} wins!!!"
  insert_blank_line
elsif dealer_total > user_total
  puts "Dealer wins, you lose.."
  insert_blank_line
else 
  puts "OMG..it's a tie!!!!!"
  insert_blank_line
end 

