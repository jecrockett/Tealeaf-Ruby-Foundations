require 'pry'

WINNING_COMBOS = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                 [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                 [[1, 5, 9], [3, 5, 7]]              # diagonals

def prompt(message)
  puts "=> #{message}"
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = ' ' }
  new_board
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  system 'clear'
  puts ""
  puts "        |         | "
  puts "   #{brd[1]}    |    #{brd[2]}    |    #{brd[3]}"
  puts "_ _ _ _ | _ _ _ _ | _ _ _ _"
  puts "        |         | "
  puts "   #{brd[4]}    |    #{brd[5]}    |    #{brd[6]}"
  puts "_ _ _ _ | _ _ _ _ | _ _ _ _"
  puts "        |         | "
  puts "   #{brd[7]}    |    #{brd[8]}    |    #{brd[9]}"
  puts "        |         | "
  puts ""
end
# rubocop:enable Metrics/AbcSize

def joinor(brd, delimiter=', ', word='or')
  if (available_squares(brd).length) > 1
    available_squares(brd).insert((available_squares(brd).length - 1), word).join(delimiter)
  end
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Please choose a square: #{joinor(brd)}"
    square = gets.chomp.to_i
    break if available_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  brd[square] = 'X'
end

def computer_places_piece!(brd)
  square = nil

  WINNING_COMBOS.each do |combo|
    square = detect_move(combo, brd, 'O')
    break if square
  end

  if !square
    WINNING_COMBOS.each do |combo|
      square = detect_move(combo, brd, 'X')
      break if square
    end
  end

  if !square && available_squares(brd).include?(5)
    square = 5
  end

  if !square
    square = available_squares(brd).sample
  end

  brd[square] = 'O'
end

def place_piece!(brd, player)
  case player
  when 'Computer'
    computer_places_piece!(brd)
  when 'Player'
    player_places_piece!(brd)
  end
end

def alternate_player(player)
  case player
  when 'Computer'
    return 'Player'
  when 'Player'
    return 'Computer'
  end
end

def available_squares(brd)
  brd.keys.select { |key| brd[key] == ' ' }
end

def board_full?(brd)
  available_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_COMBOS.each do |combo|
    if brd.values_at(*combo).count('X') == 3
      return 'Player'
    elsif brd.values_at(*combo).count('O') == 3
      return 'Computer'
    end
  end
  nil
end

def someone_wins_match?(p_wins, c_wins)
  !!detect_wins(p_wins, c_wins)
end

def detect_wins(p_wins, c_wins)
  if c_wins == 3
    return 'Computer'
  elsif p_wins == 3
    return 'Player'
  end
  nil
end

def detect_move(combo, brd, marker)
  if brd.values_at(*combo).count(marker) == 2
    brd.select { |k, v| combo.include?(k) && v == ' ' }.keys.first
  end
end

loop do
  player_wins = 0
  computer_wins = 0

  loop do # match
    board = initialize_board
    current_player = 'Player'

    loop do # individual game
      display_board(board)
      prompt "The first to three wins the match!"
      prompt "The score is: Player = #{player_wins} | Computer = #{computer_wins}"
      place_piece!(board, current_player)
      current_player = alternate_player(current_player)
      break if someone_won?(board) || board_full?(board)
    end

    display_board(board)

    if someone_won?(board)
      prompt "#{detect_winner(board)} won!"
    else
      prompt "It's a tie."
    end

    if detect_winner(board) == 'Player'
      player_wins += 1
    elsif detect_winner(board) == 'Computer'
      computer_wins += 1
    end

    break if someone_wins_match?(player_wins, computer_wins)
  end

  prompt "#{detect_wins(player_wins, computer_wins)} won the match!"

  prompt "Would you like to play again?"
  answer = gets.chomp.downcase
  break unless answer.start_with?('y')
end

puts "Thanks for playing!"
