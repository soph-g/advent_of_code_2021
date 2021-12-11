input = File
  .open('inputs/11/day_11.txt')
  .readlines
  .map(&:chomp)


grid = input.map { |line| line.chars.map(&:to_i) }


@flashes_count = 0

def flash(grid, row, col, flashed)
  return if !(0...grid.size).include?(row) || !(0...grid[0].size).include?(col)
  return if flashed[row][col]

  if grid[row][col] < 9
    grid[row][col] += 1
  else
    grid[row][col] = 0
    @flashes_count += 1
    flashed[row][col] = true
    ((row-1)..(row+1)).each do |r|
      ((col-1)..(col+1)).each do |c|
        flash(grid, r, c, flashed)
      end
    end
  end
end

100.times do |i|
  flashed = Array.new(grid.size) { Array.new(grid[0].size, false)}
  grid.each_with_index do |row, y|
    row.each_with_index do |col, x|
      flash(grid, y, x, flashed) if !flashed[y][x]
    end
  end
end

p 'Part 1'
p @flashes_count
