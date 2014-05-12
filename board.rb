# encoding: utf-8

require 'debugger'

class Board
  attr_reader :tiles
  
  BOARD_SIZE = 9
  TOTAL_MINES = 10
  
  THE_ADJACENT_EIGHT = [
    [1, -1],  [1, 0],  [1, 1], 
    [0, -1],           [0, 1],
    [-1, -1], [-1, 0], [-1, 1]
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
    
    return tiles
  end 
  
  def initialize
    @tiles = Board.new_board
  end
  
  def [](position)
    @tiles[position[0]][position[1]]
  end
  
  def display
    "    0   1   2   3   4   5   6   7   8  \n" +
    "  +---+---+---+---+---+---+---+---+---+\n" +
    @tiles.each_with_index.map do |row, index|
      "#{index} | " + row.map do |tile|
        "#{tile}"
      end.join(" | ") + " |"
    end.join("\n  +---+---+---+---+---+---+---+---+---+\n") +
    "\n  +---+---+---+---+---+---+---+---+---+\n"
     
  end  
  
  def over?   
    self.lost? || self.won?
  end
  
  def lost?
    @tiles.flatten.select do |tile|
      tile.bomb? && tile.revealed?
    end.any?
  end
  
  def won?
    @tiles.flatten.select do |tile|
      tile.bomb?
    end.all? { |tile| tile.flagged? } &&
      
    @tiles.flatten.reject do |tile|
      tile.bomb?
    end.all? { |tile| tile.revealed? }
  end
  
end