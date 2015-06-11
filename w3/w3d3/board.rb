class Board
  attr_reader :grid
  DISPLAY_HASH = {
    :ocean => '·',
  # :ship  => '•',
    :ship => '·',
    :miss  => '○',
    :hit   => '■'
  }
  
  def initialize
    @grid = Array.new(10) { Array.new(10, :ocean) }
    self.deploy
  end
  
  def deploy
    # deploys ten random 1x1 ships to the board
    # doesn't check to see if two ships share the same coords
    10.times do
      row = rand(0..9)
      col = rand(0..9)
      grid[row][col] = :ship
    end
  end
  
  def [](row, col)
    grid[row][col]
  end
  
  def []=(row, col, mark)
    grid[row][col] = mark
  end
  
  def display
    puts "  | 0 1 2 3 4 5 6 7 8 9"
    puts "──┼────────────────────"
    @grid.each_with_index { |row, idx| display_row(row, idx) }
  end
  
  def display_row(row, idx)
    spaces = row.map { |space| DISPLAY_HASH[space] }.join(' ')
    puts "#{idx} │ #{spaces}"
  end
  
  def fire_on(pos)
    raise "#{pos} was fired on already! no bueno!" if fired_on?(pos)
    if self[*pos] == :ship
      puts "KABLOOEY!"
      self[*pos] = :hit
    else
      puts "Splish..."
      self[*pos] = :miss
    end
  end
  
  def fired_on?(pos)
    (self[*pos] == :miss || self[*pos] == :hit) ? true : false
  end
  
  def count_ships
    grid.flatten.count(:ship)
  end
  
  def full?
    grid.flatten.count(:ocean) == 0
  end
end