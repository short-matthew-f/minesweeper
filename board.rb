require 'debugger'

class Board
  BOARD_SIZE = 9
  TOTAL_MINES = 10
  
  THE_ADJACENT_EIGHT = [
    [1, -1],  [1, 0],  [1, 1], 
    [0, -1],           [0, 1],
    [-1, -1], [-1, 0], [-1, 1]
  ]
  
  FOUR_CARDINALS_OF_THE_APOCALYPSE = [
    [1, 0], [0, 1], [-1, 0], [0, -1]
  ]
  
  def self.new_board
    tiles = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }
    
    (0...BOARD_SIZE).each do |row|
      (0...BOARD_SIZE).each do |col|
        tiles[row][col] = Tile.new([row, col])
      end
    end
    
    tiles.flatten.shuffle.take(TOTAL_MINES).map do |t|
      t.set_bomb
    end
    
    add_neighbors(tiles)
    
    return tiles
  end 
  
  def add_neighbors(tiles)
    tiles.each do |row|
      row.each do |tile|
        THE_ADJACENT_EIGHT.map do |x, y|
          if (tile.x+x).between?(0, BOARD_SIZE - 1) && 
            (tile.y + y).between?(0, BOARD_SIZE - 1)
            
            tile.neighbors << tiles[tile.x+x][tile.y+y]
          end
        end
      end
    end    
  end 
  
  def initialize
    @tiles = Board.new_board
  end
  
  def inspect
    "all is ok"
  end
  
  def [](position)
    @tiles[position[0]][position[1]]
  end
  
  def display
    @tiles.map do |row|
      row.map do |tile|
        "#{tile}"
      end.join(" | ")
    end.join("\n" + "--+---+---+---+---+---+---+---+--" + "\n")
  end  
  
  def render_tile(tile)
    # render differently for flagged, fringe and revealed

  end
  
end