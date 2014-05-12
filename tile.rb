class Tile
  THE_ADJACENT_EIGHT = [
    [1, -1],  [1, 0],  [1, 1], 
    [0, -1],           [0, 1],
    [-1, -1], [-1, 0], [-1, 1]
  ]
  
  FOUR_CARDINALS_OF_THE_APOCALYPSE = [
    [1, 0], [0, 1], [-1, 0], [0, -1]
  ]
  
  attr_reader :flagged, :bomb, :revealed, :position
  
  attr_accessor :neighbors
  
  def initialize(position)
    @flagged, @revealed, @bomb = false, false, false
    @neighbors = []
    @position = position
  end
  
  def to_s
    if self.flagged?
      "?"
    elsif self.revealed?
      if self.bomb?
        "*"
      elsif self.bomb_count > 0
        "#{self.bomb_count}"
      else
        "_"
      end
    else
      " "
    end  
  end
  
  def bomb_count
    @neighbors.map { |tile| tile.bomb? ? 1 : 0 }.inject(:+)
  end
  
  def x
    @position[0]
  end
  
  def y
    @position[1]
  end
  
  def bomb?
    @bomb
  end
  
  def flagged?
    @flagged
  end
  
  def revealed?
    @revealed
  end
  
  def set_bomb
    @bomb = true
  end
  
  def change_flag
    @flagged = !flagged?
  end
  
  def reveal
    @revealed = true
  end
end
