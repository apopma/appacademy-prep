class Board
  attr_accessor :grid
  
  def initialize
    @grid = Array.new(3) { Array.new(3) }
  end
  
  def [](row, col)
    @grid[row][col]
  end
  
  def []=(row, col, mark)
    @grid[row][col] = mark #sets mark
  end
  
  def winning?(ary, mark)
    # tests any set of three coords for rows, cols, and diagonals
    ary.all? {|position| position == mark}
  end
  
  def display
    @grid.each do |row|
      p row
    end
  end
  
  def row_win?(mark)
    @grid.each do |row|
      return true if winning?(row, mark)
    end
    false
  end
  
  def col_win?(mark)
    transposed_grid = @grid.transpose
    transposed_grid.each do |col|
      return true if winning?(col, mark)
    end
    false
  end
  
  def diag_win?(mark)
    diag_1 = [self[0, 0], self[1, 1], self[2, 2]]
    diag_2 = [self[2, 0], self[1, 1], self[0, 2]]
    return true if winning?(diag_1, mark) || winning?(diag_2, mark)
    false
  end
    
  def won?(mark)
    # search rows
    # transpose and search rows again, which are now columns
    # diagonals?
    return true if row_win?(mark) || (col_win?(mark) || diag_win?(mark))
    false
  end
  
  def winner
    #returns a symbol containing who the winner is
  end
  
  def empty?(*pos)
    self[*pos].nil?
  end
  
  def place_mark(*pos, mark) # 3 args
    self[*pos] = mark
  end
  
  def legal_move?(*pos)
    coords = *pos
    
    coords.all? { |coord| coord.between?(0, 2) } && self[*pos].nil? }
  end
  
end


class Game
  attr_accessor :player1, :player2, :board
  
  def initialize(player1, player2)
    @player1 = HumanPlayer.new
    @player2 = ComputerPlayer.new
    @board = Board.new
  end
  
  def play
    
    
  end
  
end


# =============================================================================

board = Board.new
board.place_mark(0, 0, :x)
#board.place_mark(1, 2, :x)
#board.place_mark(2, 2, :x)
#board.display
#p board.won?(:x)

p board.legal_move?(0, 0)
p board.legal_move?(0, 1)
p board.legal_move?(3, 3)