#TicTacToe game for Tealeaf Academy 

# setup the game board and display it 
# user has a turn 
# computer has a turn 
# update the display of the board 
# check for a winner after each turn 

WINNING_POSITIONS = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]

def display_game_board(board)
  puts
  puts "     |     |"
  puts "  #{board[1]}  |  #{board[2]}  |  #{board[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{board[4]}  |  #{board[5]}  |  #{board[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{board[7]}  |  #{board[8]}  |  #{board[9]}"
  puts "     |     |"
  puts
end 

def initialize_game_board
  board = {}
  (1..9).each{ |num| board[num] = " " }
  board 
end 

def user_selects_square(board)
  begin 
    puts "Please enter a number (1-9)"
    key = gets.chomp.to_i 
  end until available_squares(board).include?(key)
  board[key] = "X"
end 

def comp_selects_square(board)
  #simple AI for computer 
  key = available_squares(board).sample
  board[key] = "O"
end 
  
def have_a_winner?(board)
  WINNING_POSITIONS.each do |pos|
    if board[pos[0]] == "X" && board[pos[1]] == "X" && board[pos[2]] == "X"
      return "You"
    elsif board[pos[0]] == "O" && board[pos[1]] == "O" && board[pos[2]] == "O"
      return "Computer"
    end
  end 
  nil  
end

def available_squares(board)
  board.keys.select{|key| board[key] == " " }
end
    
def all_squares_filled?(board)
  available_squares(board) == []
end   

board = initialize_game_board 
display_game_board(board) 

begin
  user_selects_square(board)
  comp_selects_square(board)
  display_game_board(board)
  winner = have_a_winner?(board)
end until winner || all_squares_filled?(board)

if winner == "You"
  puts "#{winner} are the winner!!!!"
elsif winner == "Computer"
  puts "#{winner} is the winner"
else 
  puts"Its a tie"
end 


