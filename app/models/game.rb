class Game < ApplicationRecord
  has_many :moves, dependent: :destroy
  has_many :players

  def get_board
    board = Array.new(3){Array.new(3, " ")}
    player_ids = self.moves.pluck(:player_id).uniq
    player_1 = player_ids[0]
    player_2 = player_ids[1]
    self.moves.each_with_index do |move, i|
      board[ move.y ][ move.x ] = (move.player_id == player_1) ? "X" : "O"
    end

    board
  end

  def is_finished?
    if self.get_winner != nil or self.moves.count == 9 then
      return true
    else
      return false
    end
  end

  def get_winner
    board = self.get_board()

    # Three horizontal
    board.each do |row|
      next if row[0] == " "
      if row.uniq.length == 1
       return (row.uniq.first == "X") ? "Player1" : "Player2"
     end
    end

    # Three vertical
    board.transpose.each do |col|
      next if col[0] == " "
      if col.uniq.length == 1
       return (col.uniq.first == "X") ? "Player1" : "Player2"
      end
    end

    # Three diagonal
    if board[0][0] != " " and 
       board[0][0] == board[1][1] and 
       board[1][1] == board[2][2] then
       return ((board[0][0] == "X") ? "Player1" : "Player2")
    end

    if board[2][0] != " " and
       board[2][0] == board[1][1] and
       board[1][1] == board[0][2] then
       return ((board[2][0] == "X") ? "Player1" : "Player2")
     end

    return nil
  end
end
