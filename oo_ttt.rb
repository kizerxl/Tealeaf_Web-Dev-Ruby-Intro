# Tic Tac Toe OO style 
# Game has 2 players take turns in a game of tic tac toe
# One player is the computer and the other is a user 
# There is a game board that is updated and checked for a winner
# each turn 

class Player
  attr_accessor :name, :sign 
  
  def initialize(name, sign)
    @name = name 
    @sign = sign 
  end 

end 

class Computer < Player
  def initialize(name="Computer",sign="O")
    super(name, sign)
  end 
end 

class Human < Player 
  def initialize(name="User", sign="X")
    super(name, sign)
  end 
end 

class Board 
  WINNING_POSITIONS = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
  
  def initialize
    @board = {}
    (1..9).each{ |position| @board[position] = Tile.new(" ") }
  end 
  
  def draw
    system 'clear'
    puts "     |     |"
    puts "  #{@board[1]}  |  #{@board[2]}  |  #{@board[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@board[4]}  |  #{@board[5]}  |  #{@board[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@board[7]}  |  #{@board[8]}  |  #{@board[9]}"
    puts "     |     |"
    puts
  end 

  def have_a_winner?(sign)
    WINNING_POSITIONS.each do |win_position| 
      if ( (@board[ win_position[0] ].sign == sign ) && 
        (@board[ win_position[1] ].sign == sign ) && 
        (@board[ win_position[2] ].sign == sign) )
        return true 
      end 
    end 
    false
  end 
    
  def sign_board(position, sign)
    @board[position].sign_tile(sign)
  end 

  
  def free_tiles
    @board.select{|_, tile| tile.empty? }.values
  end

  def free_tile_positions
    @board.select{|_, tile| tile.empty? }.keys
  end
  
  def all_tiles_filled?
    free_tiles.length == 0 
  end 

  def reset_board
    @board.each{ |_, tile| tile.sign_tile(" ")}
    
  end 

end 

class Tile 
  attr_reader :sign
  def initialize(sign)
    @sign = sign 
  end
  
  def sign_tile(sign)
    @sign = sign
  end 
  
  def empty? 
    @sign == " "
  end 

  def to_s 
    @sign 
  end 

end 

class GameEngine
  attr_reader :human, :computer
  attr_accessor :current_player
  
  def initialize
    puts"Let's play Tic Tac Toe.\nWhat is your name?"
    name = gets.chomp

    @new_board = Board.new
    @human = Human.new(name,"X")
    @computer = Computer.new("Computer", "O")
    @current_player = @human
  end 
  
  def current_player_turn
    if @current_player == @human 
      begin 
        puts "Please select one of the following free tiles: #{@new_board.free_tile_positions}"
        choice = gets.chomp.to_i
      end until @new_board.free_tile_positions.include?(choice) 
    else
        choice = @new_board.free_tile_positions.sample
    end
    @new_board.sign_board(choice, @current_player.sign)
  end 
  
  def change_player
    if @current_player == @human 
      @current_player = @computer
    else 
      @current_player = @human
    end 
  end 

  def start 
    begin 
      begin 
        @new_board.draw
        current_player_turn
        @new_board.draw
        break if @new_board.have_a_winner?(@current_player.sign)
        change_player
      end until @new_board.all_tiles_filled? 
    
      if @new_board.all_tiles_filled?
        puts"Looks like it's a tie.."
      elsif @current_player == @human 
        puts "#{@current_player.name} wins!"
      else 
        puts "#{@current_player.name} wins, you lose...." 
      end 
      #reset player start for new game
      @current_player = @human 
      puts "play again(y/n):"
      again = gets.chomp.downcase
      @new_board.reset_board if again.downcase == "y"
    end until again != "y"
      puts "Thanks for playing"
    end 
end 

GameEngine.new.start 
