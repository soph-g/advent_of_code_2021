input = File
  .open('inputs/09/day_09.txt')
  .readlines
  .map(&:chomp)
  .map { |l| l.split('') }
  .map { |arr| arr.map!(&:to_i) }

# Part 1

sum = 0
row = 0
col = -1

while row < input.length do
  while col < input[0].length - 1 do
    col += 1

    current = input[row][col]
    next if col > 0 && input[row][col-1] <= current
    next if col < input[row].length-1 && input[row][col+1] <= current
    next if row > 0 && input[row-1][col] <= current
    next if row < input.length-1 && input[row+1][col] <= current

    sum += (current + 1)
  end

  row += 1
  col = -1
end

p 'Part 1'
p sum

# Part 2

@basin_areas = []
@input = input

def calculate_basin_area(row, col, sum, visited = Hash.new(false))
  return sum if row < 0 || row >= @input.length
  return sum if col < 0 || col >= @input[0].length
  return sum if @input[row][col] == 9
  return sum if visited[[row, col]]

  sum += 1
  visited[[row, col]] = true

  sum = calculate_basin_area(row-1, col, sum, visited)
  sum = calculate_basin_area(row, col+1, sum, visited)
  sum = calculate_basin_area(row+1, col, sum, visited)
  sum = calculate_basin_area(row, col-1, sum, visited)

  sum
end

row = 0
col = -1

while row < @input.length do
  while col < @input[0].length - 1 do
    col += 1

    current = @input[row][col]
    next if col > 0 && @input[row][col-1] <= current
    next if col < @input[row].length-1 && @input[row][col+1] <= current
    next if row > 0 && @input[row-1][col] <= current
    next if row < @input.length-1 && @input[row+1][col] <= current

    area = calculate_basin_area(row, col, 0)
    @basin_areas << area
  end

  row += 1
  col = -1
end

p 'Part 2'
p @basin_areas.sort.reverse[0..2].reduce(:*)
