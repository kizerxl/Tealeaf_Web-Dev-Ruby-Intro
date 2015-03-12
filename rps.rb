#Tealeaf Web development + Ruby intro 
#Rock, Paper, Scissors game 
#Winning conditions: rock > scissors, paper > rock, scissors > paper  

choices = {'r' => "Rock", 'p' => "Paper", 's' => "Scissors" }
winner = ["You", "Computer"]

def Win_Message winning_choice,winner,loser
  if loser == "You"
    loser =  "your"
  else 
    loser = "computer's"
end

case winning_choice

  when "r"
    puts "#{winner} threw a rock and knocked the scissors out of #{loser} hand!" 
  when "p"
    puts "#{winner} took some paper and wrapped #{loser} pathetic rock!"
  when "s"
    puts "#{winner} grabbed a pair of scissors and cut #{loser} paper to shreds!"
  end

end 

loop do

  begin 
    puts "Classic Rock, Paper Scissors. Please type r, p, s for your choice:"
    user_choice = gets.chomp.downcase 
  end until choices.keys.include?(user_choice) 

  puts "You selected #{choices[user_choice]}"

  computer_choice = choices.keys.sample 
  puts "The computer selected #{choices[computer_choice]}"
  
  if computer_choice == user_choice 
    puts "Its a tie!!!" 
  elsif (user_choice == "r" && computer_choice == "s") || 
    (user_choice == "p" && computer_choice == "r") || 
    (user_choice == "s" && computer_choice == "p")
    Win_Message(user_choice,winner[0],winner[1])
    puts "You wooooooon!!"  
  else 
    Win_Message(computer_choice,winner[1],winner[0])
    puts "Ah man, the computer won. Wah wah wah..."
  end 

  puts"Play again (y/n)?"
  again = gets.chomp.downcase 
  break if again != "y"

end 

