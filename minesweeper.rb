require './tile.rb'
require './board.rb'

class Minesweeper
  THE_ADJACENT_EIGHT = [
    [1, -1],  [1, 0],  [1, 1], 
    [0, -1],           [0, 1],
    [-1, -1], [-1, 0], [-1, 1]
  ]
  
  attr_reader :board
  
  # public methods
  def initialize(board)
    @board = board
  end
  
  def play
    until @board.over?
      puts @board.display
      
      update_board(get_tile, get_action)
    end
    
    puts @board.display
    puts @board.lost? ? "You lose!" : "You won!"
  end
  
  private
  
  def update_board(tile, action)
    if ["f", "u"].include?(action)
      tile.change_flag
    else    
      if tile.bomb?
        @board.tiles.map do |row|
          row.map do |t|
            t.reveal
          end
        end
      else
        tile.spread_out
      end
    end
  end
  
  def get_tile
    begin
      puts "Which tile do you want to click? (as row, col)"
      user_input = gets.chomp.split(", ")
      pos = [Integer(user_input[0]), Integer(user_input[1])]
    rescue
      puts "Seriously?"
      retry
    end
    
    @board[pos]
  end
  
  def get_action
    action = nil
    
    until action
      puts "What do you want to do: (f)lag, (u)nflag, or (r)eveal?"
      user_input = gets.chomp.downcase
      action = user_input if ["f", "u", "r"].include?(user_input)
    end
    
    action
  end
end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  game = Minesweeper.new(board)
  game.play
end