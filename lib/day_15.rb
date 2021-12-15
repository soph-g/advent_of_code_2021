input = File
  .open('inputs/15/day_15.txt')
  .readlines
  .map(&:chomp)
  .map(&:chars)
  .map { |l| l.map(&:to_i) }

p 'Part 1'
def find_paths(map)
  lowest_paths = Array.new(map.size) { Array.new(map[0].size, Float::INFINITY) }
  lowest_paths[0][0] = 0
  finished = Array.new(map.size) { Array.new(map[0].size, false) }
  finished[0][0] = true

  stack = {
    [0, 1] => { row: 0, col: 1, prev: [0, 0], val: map[0][1] },
    [1, 0] => { row: 1, col: 0, prev: [0, 0], val: map[1][0] }
  }

  find_path(map, stack, lowest_paths, finished)

  lowest_paths[-1][-1]
end

def find_path(map, queue, lowest_paths, visited)
  while !queue.empty? do
    cur = queue.values.min_by { |v| v[:val] }
    queue.delete([cur[:row], cur[:col]])
    row, col = cur[:row], cur[:col]

    next if visited[row][col]

    visited[row][col] = true
    tmp = map[row][col] + lowest_paths[cur[:prev][0]][cur[:prev][1]]

    next if tmp > lowest_paths[row][col]

    lowest_paths[row][col] = tmp
    queue_next(map, row, col, cur[:prev], queue, lowest_paths, visited)
  end
end

def queue_next(map, row, col, prev, queue, lowest_paths, finished)
  next_paths = []
  moves = [[row, col + 1], [row + 1, col], [row, col - 1], [row - 1, col]]

  moves.each do |move|
    r, c = move[0], move[1]
    next if c < 0 || c >= map[0].size
    next if r < 0 || r >= map.size
    next if [r, c] == prev || finished[r][c]

    tmp = map[r][c] + lowest_paths[row][col]
    if tmp < lowest_paths[r][c] && !queue[[r, c]] || queue[[r, c]][:val] > tmp
      queue[[r, c]] = { row: r, col: c, prev: [row, col], val: tmp }
    end
  end
end

result = find_paths(input)
p result

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
