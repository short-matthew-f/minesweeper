class Minesweeper
  TOTAL_MINES = 10
  
  attr_reader :board
  
  # factory methods
  def self.new_board
    board = (0..8).map do |row|
      (0..8).map do |tile|
        Tile.new
      end
    end
    
    board.flatten.shuffle.take(10).map do |t|
      t.set_bomb
    end
    
    board
  end  
  
  # public methods
  def initialize(board = nil)
    @board = board || Minesweeper.new_board
  end
  
  # private methods
  
  private
  
  # protected methods
  
  protected
  
  
end

class Tile
  attr_reader :flagged, :bomb, :fringe
  
  def initialize
  end
  
  def bomb?
    @bomb
  end
  
  def flagged?
    flagged
  end
  
  def fringe?
    fringe
  end
  
  def set_bomb
    @bomb = true
  end
end
