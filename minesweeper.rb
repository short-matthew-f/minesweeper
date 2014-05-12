require './tile.rb'
require './board.rb'

class Minesweeper
  attr_reader :board
  
  # public methods
  def initialize(board)
    @board = board
  end
  
  def play
    until over?
      puts display_board
      
      tile = get_tile
      action = get_action
      
      update_board(tile, action)
    end
  end
  
  def update_board(tile, action)
    if ["flag", "unflag"].include?(action)
      tile.change_flag
    else    
      if tile.bomb?
        @board.map do |row|
          row.map do |t|
            t.reveal
          end
        end
      else
        spread_out_from(tile)
      end
    end
  end
  
  def spread_out_from(tile)
    tile.reveal
    
    tile.four_cardinals.each do |t|
      next if t.bomb? || t.revealed?
      
      spread_out_from(t)
    end
  end
  
  def get_tile
    puts "Which tile do you want to click?"
    
    pos = gets.chomp.split(", ").map(&:to_i)
    
    @board[pos[0]][pos[1]]
  end
  
  def get_action
    puts "What do you want to do? (flag, unflag, or reveal)"
    
    action = gets.chomp
  end
  
  def over?   
    lost? || won?
  end
  
  def lost?
    @board.flatten.select do |tile|
      tile.bomb? && tile.revealed?
    end.any?
  end
  
  def won?
    @board.flatten.select do |tile|
      tile.bomb?
    end.all? { |tile| tile.flagged? } &&
      
    @board.flatten.reject do |tile|
      tile.bomb?
    end.all? { |tile| tile.revealed? }
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