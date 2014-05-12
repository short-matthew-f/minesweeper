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
      tile.reveal
      
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
    # look at all 8 adjacent tiles
    # count how many are bombs
    # if there are bombs, set it as a fringe & the bomb count == value
    # spread_out_from north, east, south, west tiles which haven't been revealed & are not bombs
    
    
    
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
  
  def display_board
    @board.map do |row|
      row.map do |tile|
        render_tile(tile)
      end.join(" | ")
    end.join("\n" + "--+---+---+---+---+---+---+---+--" + "\n")
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
  
  def render_tile(tile)
    # render differently for flagged, fringe and revealed
    if tile.flagged?
      "?"
    elsif tile.fringe?
      "#{number_of_nearby_bombs(tile)}"
    elsif tile.revealed? && tile.bomb?
      "*"
    elsif tile.revealed?
      "_"
    else
      " "
    end
  end
  
  def adjacent_bombs(tile)
    tile.position
  end
end

if __FILE__ == $PROGRAM_NAME
  board = Board.new()
  game = Minesweeper.new(board)
  game.play
end