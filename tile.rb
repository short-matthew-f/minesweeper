class Tile

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
  
  def spread_out
    self.reveal
    
    unless self.bomb_count > 0
      self.neighbors.each do |t|
        next if t.bomb? || t.revealed?
      
        t.spread_out
      end
    end
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
