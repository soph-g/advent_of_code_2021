input = File.open('inputs/04/day_04.txt').readlines.map(&:chomp)
numbers = input.first.split(',').map(&:to_i)
input = input[2...input.length]

def build_boards(input)
  boards = []
  board = []
  input.each do |line|
    if line == ''
      boards << board
      board = []
    else
      board << line.split(' ').map(&:to_i)
    end
  end

  boards << board
end

boards = build_boards(input)


=begin
for each number in numbers:
- iterate over a board to check if the number is present
- if it is, replace it with -1, then check to see if the board has won
- if a board has won, stop the numbers checking process, and store the winning number
    - sum up the non-negative numbers in the winning board
    - multiply this by the prize number to get the result

- checking winners
  - check rows(can move to the next row as soon as a non negative number is found)
  - check columns (can move to the next column as soon as a non negative number is found)
  - if a row or column with no non-negative nummbers in, stop and return the board
  - return nil if the board has not won
=end

def winning_row(board)
  r = 0

  while r < board.length do
    c = 0
    c += 1 while c < board[r].length && board[r][c] < 0
    return true if c == board[r].length
    r += 1
  end

  false
end

def winning_column(board)
  c = 0
  while c < board.first.length
    r = 0
    r += 1 while r < board.length && board[r][c] < 0
    return true if r == board.length
    c += 1
  end

  false
end

def mark_number(board, num)
  board.each_with_index do |line, r|
    line.each_with_index do |n, c|
      if n == num
        board[r][c] = -1
        return true
      end
    end
  end
end

def check_for_win(board, num, result)
  if winning_row(board) || winning_column(board)
    result[:number] = num
    result[:board] = board
    return result
  end
end

def check_numbers(numbers, boards, result)
  numbers.each do |num|
    return result if result[:number] && result[:board]

    boards.each do |board|
      return result if result[:number] && result[:board]
      check_for_win(board, num, result) if mark_number(board, num)
    end
  end
end

def find_winning_board(numbers, boards)
  result = {
    number: nil,
    board: nil,
  }

  check_numbers(numbers, boards, result)
end

result = find_winning_board(numbers, boards.dup)
winning_number = result[:number]
board_total = 0
result[:board].each do |line|
  line.each do |num|
    board_total += num if num > 0
  end
end

p 'Part 1'
p winning_number * board_total

# Part 2

def check_for_win(board, num)
  return true if winning_row(board) || winning_column(board)
end

def check_numbers(numbers, boards, winning_boards)
  numbers.each do |num|
    i = 0
    while i < boards.length do
      if mark_number(boards[i], num)
        if check_for_win(boards[i], num)
          winning_boards << [boards[i], num]
          boards = boards[0...i] + boards[(i + 1)...boards.length]
        else
          i += 1
        end
      end
    end
  end

  winning_boards
end

def find_winning_board(numbers, boards)
  winning_boards = []

  check_numbers(numbers, boards, winning_boards)

  winning_boards
end

result = find_winning_board(numbers, boards.dup).last

winning_number = result.last
board_total = 0
result.first.each do |line|
  line.each do |num|
    board_total += num if num > 0
  end
end

p 'Part 2'
p winning_number * board_total
