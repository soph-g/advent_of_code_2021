input = File
  .open('inputs/13/day_13.txt')
  .readlines
  .map(&:chomp)

coords = []
instructions = []

input.each do |line|
  next if line == ''
  if ('0'..'9').include?(line[0])
    coords << line.split(',').map(&:to_i)
  else
    instructions << line.split(' ')[-1].split('=')
  end
end

=begin
row = 1 => coord[1]
col = 0 => coord[0]
=end

def build_template(coordinates)
  max_col = coordinates.map { |coord| coord[0] }.max
  max_row = coordinates.map { |coord| coord[1] }.max

  Array.new(max_row+1) { Array.new(max_col+1, 0) }
end

grid = build_template(coords)

coords.each do |coord|
  r = coord[1]
  c = coord[0]

  grid[r][c] = 1
end

def fold_up(grid, row)
  (grid.size - row - 1).times do |i|
    top = row - i - 1
    bottom = row + i + 1

    grid[bottom].each_with_index do |val, x|
      grid[top][x] = 1 if val == 1
    end
  end

  grid.slice(0...row)
end

def fold_left(grid, col)
  (grid[0].size - col - 1).times do |i|
    left = col - i - 1
    right = col + i + 1

    grid.each_with_index do |row, x|
      grid[x][left] = 1 if row[right] == 1
    end
  end
  grid.map { |row| row.slice(0...col)}
end

def fold_grid(grid, instructions)
  folded = grid
  instructions.each do |ins|
    if ins[0] == 'y'
      folded = fold_up(folded, ins[1].to_i)
    else
      folded = fold_left(folded, ins[1].to_i)
    end
  end

  folded
end

p 'PART 1'
folded = fold_grid(grid.dup, instructions[0])
p folded.map { |line| line.reduce(:+) }.reduce(:+)

p 'PART 2'
folded = fold_grid(grid, instructions)
folded.each { |l| p l }
