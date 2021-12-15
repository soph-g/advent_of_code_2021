input = File
  .open('inputs/15/test.txt')
  .readlines
  .map(&:chomp)
  .map(&:chars)
  .map { |l| l.map(&:to_i) }

p 'Part 1'

def find_paths(map)
  lowest_paths = Array.new(map.size) { Array.new(map[0].size) }

  lowest_paths[-1][-1] = map[-1][-1]

  find_path(map, 0, 0, lowest_paths)

  return lowest_paths[0][0] - map[0][0]
end

def find_path(map, row, col, lowest_paths)
  return lowest_paths[row][col] if lowest_paths[row][col]

  right = find_path(map, row, col + 1, lowest_paths) if col < map[row].size - 1
  down = find_path(map, row + 1, col, lowest_paths) if row < map.size - 1

  lowest_paths[row][col] = map[row][col]

  lowest_paths[row][col] += right if down.nil?
  lowest_paths[row][col] += down if right.nil?
  lowest_paths[row][col] += [right, down].min if right && down

  return lowest_paths[row][col]
end

# p find_paths(input)

p 'Part 2'

big_map = Array.new(input.size * 5) { Array.new(input[0].size * 5) }

def build_big_map(map, grid, row, col)
  return if row == map.size || col == map[0].size
  return if map[row][col]

  grid.each_with_index do |r, y|
    r.each_with_index do |c, x|
      map[row + y][col + x] = c
    end
  end

  next_grid = grid.map do |l|
    l.map do |n|
      n == 9 ? 1 : n + 1
    end
  end

  build_big_map(map, next_grid, row + grid.size, col)
  build_big_map(map, next_grid, row, col + grid[0].size)
end

build_big_map(big_map, input, 0, 0)

p find_paths(big_map)
