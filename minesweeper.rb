require './tile.rb'
require './board.rb'

class Minesweeper
  attr_reader :board
  
  # public methods
  def initialize(board)
    @board = board
  end
  
  def play
    until @board.over?
      puts @board.display
      
      tile = get_tile
      action = get_action
      
      update_board(tile, action)
    end
    
    puts @board.lost? ? "You lose!" : "You won!"
  end
  
  def update_board(tile, action)
    if ["flag", "unflag"].include?(action)
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
    puts "Which tile do you want to click?"
    
    pos = gets.chomp.split(", ").map(&:to_i)
    
    @board[pos]
  end
  
  def get_action
    puts "What do you want to do? (flag, unflag, or reveal)"
    
    action = gets.chomp
  end
  


  # private methods
  
  private
  
  # protected methods
  
  protected
  
end

if __FILE__ == $PROGRAM_NAME
  board = Board.new()
  game = Minesweeper.new(board)
  game.play
end