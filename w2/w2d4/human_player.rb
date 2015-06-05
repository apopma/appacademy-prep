class HumanPlayer
  attr_reader :mark
  def initialize(mark)
    @mark = mark
  end
  
  def move(board)
    while true 
      print "Please enter a grid coordinate to mark (ex: '1, 2'): "
      coords = gets.chomp.split(",").map(&:to_i)
      
      if !board.legal_move?(coords)
        puts "Sorry, that move's illegal!"
      else
        break
      end
    end
    coords
  end
end