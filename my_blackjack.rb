#Blackjack 
#Tealeaf Academy 

SUITS = ["Hearts", "Diamonds", "Spades", "Clubs"]
CARDS = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "ACE", "KING", "QUEEN", "JESTER"]
BLACKJACK = 21
DEALER_HIT_LIMIT = 17

#calculates score for respective hand 
def calculate_score(hand_of_cards)
  card_values = hand_of_cards.map{|card_value| card_value[1]}
  total = 0 
  card_values.each do |card_value| 
    if card_value == "ACE"
      total+= 11
    elsif card_value.to_i == 0 #For suits ie Jester, Queen
      total+= 10
    else 
      total+= card_value.to_i
    end
  end 

#adjust for Aces
  card_values.select{|card| card == "ACE"}.count.times do 
    total-=10 if total > 21
  end 
  total
end 

#format cards 
def format_card(card)
  card[1] +" of "+ card[0]
end 

def deal_first_cards(user_hand, dealer_hand, deck)
  2.times do 
    user_hand<< deck.pop 
    dealer_hand<< deck.pop 
  end 
end 

def insert_blank_line
  puts ""
end 

def output_cards(hand_of_cards)
  card_list = []
  hand_of_cards.each do |card| 
    card_list<< format_card(card)
  end 
  formatted_cards = card_list.join(", ")
end 

def compare_hands(user_hand, dealer_hand, name) 
  user_total = calculate_score(user_hand)
  dealer_total = calculate_score(dealer_hand)
  puts "#{name} has #{output_cards(user_hand)} with a total of #{user_total}"
  puts "Dealer has #{output_cards(dealer_hand)} with a total of #{dealer_total}"

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
end 

#Our game 
begin
  user_hand = []
  dealer_hand = []
  win_or_bust = false 

  #make deck of cards and shuffle 
  deck = SUITS.product(CARDS)
  deck.shuffle! 
  
  puts "What is your name?"
  name = gets.chomp
  insert_blank_line
  puts "Let's play #{name}"
  insert_blank_line
  deal_first_cards(user_hand, dealer_hand, deck)
  insert_blank_line

  user_total = calculate_score(user_hand)
  dealer_total = calculate_score(dealer_hand)

  puts "#{name} has #{output_cards(user_hand)} with a total of #{user_total}"
  puts "Dealer has a total of #{dealer_total}"
  insert_blank_line

  if user_total == BLACKJACK 
    puts "#{name} hit blackjack! #{name} wins!!!"
    insert_blank_line
    win_or_bust = true
  end 

    #User turn 
  while user_total < BLACKJACK && win_or_bust == false 
    puts "#{name}, enter 1 to hit or 2 to stay:"
    choice = gets.chomp 

    if !['1','2'].include?(choice)
      next
    end 

    if choice == '1'
      puts "#{name} has chosen to hit"
      user_hand<< deck.pop
      user_total = calculate_score(user_hand)
      puts "#{name} has the following cards: #{output_cards(user_hand)}"
      puts "with a total of #{user_total}"
    end

    if user_total == BLACKJACK
      puts "#{name} hit blackjack! #{name} wins!!!"
      insert_blank_line
      win_or_bust = true 
      break
    elsif user_total > BLACKJACK 
      puts "#{name} has busted. Dealer wins, you lose..."
      insert_blank_line
      win_or_bust = true
      break 
    end 

    if choice == "2"
      puts "#{name} has chosen to stay"
      insert_blank_line
      break
    end 

  end 

    #Dealer turn 

  if dealer_total == BLACKJACK 
    puts "Dealer has hit blackjack. #{name} has lost.."
    insert_blank_line
    win_or_bust = true 
     
  elsif win_or_bust == false 
     
    while dealer_total < DEALER_HIT_LIMIT

      #keep hitting 
      dealer_hand<<deck.pop 
      dealer_total = calculate_score(dealer_hand)
      puts "Dealer has a total of #{dealer_total}"
      insert_blank_line

      if dealer_total == BLACKJACK
        puts "Dealer has hit blackjack. #{name} has lost.."
        insert_blank_line
        win_or_bust = true 
        break
      elsif dealer_total > BLACKJACK
        puts "Dealer has busted. #{name} wins!"
        insert_blank_line
        win_or_bust = true 
        break
      end

    end

  end 
  
  if win_or_bust == false 
    compare_hands(user_hand, dealer_hand, name)
  end 
  
  puts "Play again? (y/n):" 
  again = gets.chomp.downcase

end while again == 'y'

