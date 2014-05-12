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
  
  def play
    until over?
      display_board
      
    end
  end
  
  def display_board
    
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
    end.all? { |tile| tile.flagged? }
    
      &&
    
    @board.flatten.reject do |tile|
      tile.bomb?
    end.all? { |tile| tile.revealed? }
  end

  # private methods
  
  private
  
  # protected methods
  
  protected
  
  def render_tile(tile)
    # render differently for flagged, fringe and revealed
    if tile.flagged?
      "?"
    elsif tile.fringe?
      "#{number_of_nearby_bombs(tile)}"
    elsif tile.revealed?
      "_"
    else
      " "
    end
  end
  
  def number_of_nearby_bombs(tile)
    
  end
end

class Tile
  attr_reader :flagged, :bomb, :fringe, :revealed
  
  def initialize
  end
  
  def bomb?
    @bomb
  end
  
  def flagged?
    @flagged
  end
  
  def fringe?
    @fringe
  end
  
  def revealed?
    @revealed
  end
  
  def set_bomb
    @bomb = true
  end
end
