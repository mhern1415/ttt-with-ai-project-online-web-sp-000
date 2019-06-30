class Game
  
attr_accessor :board, :player_1, :player_2

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6] ]
  
def initialize(player_1=Players::Human.new("X"), player_2=Players::Human.new("O"), board=Board.new)
  @player_1 = player_1
  @player_2 = player_2
  @board = board
  @board.display
end

def current_player
  @board.turn_count % 2 == 0 ? player_1 : player_2
end


def over?
  won? || draw?
end

 def winner
    board.cells[won?[0]] if won?
  end

def won?
   WIN_COMBINATIONS.each do |combination|   #[0,1,2] which is board range (0-8)
       if @board.cells[combination[0]] == @board.cells[combination[1]] &&
         @board.cells[combination[1]] == @board.cells[combination[2]] &&
         @board.taken?(combination[0]+1)
         #Need to +1, because #taken? rspec test is working off user_input range (1-9)
         return combination
       end
     end
   return false
 end


def draw?
  @board.full? && !won?
end

end