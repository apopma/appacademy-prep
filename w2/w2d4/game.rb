class Game
  attr_accessor :players, :board
  
  def initialize(player1, player2)
    @players = [player1, player2]
    @board = Board.new
  end
  
  def play
    @board.display
    while true
      @players.each_with_index do |player, idx|
        puts "It's player #{idx + 1}'s turn. (#{player.mark})"
        
        mark = player.mark
        coords = player.move(@board)
        @board.place_mark(coords, mark)
        @board.display
          
        if @board.won?(mark)
          puts "#{mark.upcase} wins the game!"
          return
        elsif @board.tie?
          puts "This game's a tie!"
          return
        end
        
      end
    end
  end
end