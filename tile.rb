class Tile
  THE_ADJACENT_EIGHT = [
    [1, -1],  [1, 0],  [1, 1], 
    [0, -1],           [0, 1],
    [-1, -1], [-1, 0], [-1, 1]
  ]
  
  FOUR_CARDINALS_OF_THE_APOCALYPSE = [
    [1, 0], [0, 1], [-1, 0], [0, -1]
  ]
  
  attr_reader :flagged, :bomb, :fringe, :revealed, :position
  
  attr_accessor :neighbors
  
  def initialize(position)
    @flagged, @revealed, @bomb, @fringe = false, false, false, false
    @neighbors = []
    @position = position
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
  
  def fringe?
    @fringe
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
