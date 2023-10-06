# Initialize the Tic-Tac-Toe board
board = Array.new(3) { Array.new(3, ' ') }

# Function to display the board
def display_board(board)
  puts "  1 2 3"
  puts " -------"
  board.each_with_index do |row, idx|
    puts "#{idx + 1}|#{row.join('|')}|"
    puts " -------" if idx < 2
  end
end

# Function to check if the game is over
def game_over?(board)
  # Check rows, columns, and diagonals for a win
  board.each do |row|
    return true if row.uniq.length == 1 && row[0] != ' ' && row[0] != '_'
  end

  board.transpose.each do |column|
    return true if column.uniq.length == 1 && column[0] != ' ' && column[0] != '_'
  end

  diagonals = [[board[0][0], board[1][1], board[2][2]], [board[0][2], board[1][1], board[2][0]]]
  diagonals.each do |diagonal|
    return true if diagonal.uniq.length == 1 && diagonal[0] != ' ' && diagonal[0] != '_'
  end

  # Check if the board is full (a draw)
  return true if board.flatten.none?(' ')

  false
end

# Function to get a valid move from the player
def get_move(player, board)
  loop do
    print "#{player}, enter your move (row and column, e.g., 1 2): "
    move = gets.chomp.split.map(&:to_i)
    if move.length == 2 && (1..3).include?(move[0]) && (1..3).include?(move[1]) &&
       board[move[0] - 1][move[1] - 1] == ' '
      return move
    else
      puts "Invalid move. Please try again."
    end
  end
end

# Main game loop
current_player = 'X'
until game_over?(board)
  display_board(board)
  move = get_move(current_player, board)
  row, col = move[0] - 1, move[1] - 1
  board[row][col] = current_player
  current_player = (current_player == 'X') ? 'O' : 'X'
end

# Display the final result
display_board(board)
if game_over?(board)
  winner = (current_player == 'X') ? 'O' : 'X'
  puts "Game over! #{winner} wins!"
else
  puts "It's a draw!"
end

