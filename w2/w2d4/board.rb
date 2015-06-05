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
  
  def display
    @grid.each do |row| 
      p row
    end
  end
  
  
  def winning?(ary, mark)
    # tests any set of three coords for rows, cols, and diagonals
    ary.all? {|position| position == mark}
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
    return true if row_win?(mark) || (col_win?(mark) || diag_win?(mark))
    false
  end
  
  def empty?(row, col)
    self[row, col].nil?
  end
  
  def empty_spaces
    empties = []
    (0..2).each do |row|
      (0..2).each do |col|
        empties << [row, col] if @grid[row][col].nil?
      end
    end
    empties
  end

  def place_mark(pos, mark) # 3 args
    self[*pos] = mark
  end
  
  def legal_move?(pos)
    # True if indices given are between 0 and 2, and no move exists at this pos
    return false if !pos.all? { |coord| coord.between?(0, 2) }
    return false if !self[*pos].nil?
    true
  end
  
  def is_full?
    @grid.flatten.compact.length == 9
  end
  
  def tie?
    is_full? && (!won?(:x) && !won?(:o))
  end
  
end