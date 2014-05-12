class Tile
  attr_reader :flagged, :bomb, :fringe, :revealed, :position
  
  def initialize(pos)
    @flagged, @revealed, @bomb, @fringe = false, false, false, false
    @position = pos
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
