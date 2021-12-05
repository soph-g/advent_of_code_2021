input = File.open('inputs/05/day_05.txt').readlines.map(&:chomp)

input.map! { |line| line.split(' -> ') }
input.map! do |arr|
  arr.map! { |s| s.split(',') }
  arr.each do |a|
    a.map!(&:to_i)
  end
end

@dangerous_points = 0

def add_horizontal_line(map, coords)
  l = coords[0][0] < coords[1][0] ? coords[0][0] : coords[1][0]
  r = coords[0][0] > coords[1][0] ? coords[0][0] : coords[1][0]
  row = coords[0][1]

  x = 0
  (l..r).each do |x|
    @dangerous_points += 1 if map[row][x] == 1
    map[row][x] = map[row][x] + 1
  end
end

def add_vertical_line(map, coords)
  t = coords[0][1] < coords[1][1] ? coords[0][1] : coords[1][1]
  b = coords[0][1] > coords[1][1] ? coords[0][1] : coords[1][1]
  col = coords[0][0]

  (t..b).each do |x|
    @dangerous_points += 1 if map[x][col] == 1
    map[x][col] = map[x][col] + 1
  end
end

def build_map_template(directions)
  max_row = 0
  max_col = 0

  directions.each do |coords|
    max_row = coords[0][1] if coords[0][1] > max_row
    max_row = coords[1][1] if coords[1][1] > max_row

    max_col = coords[0][0] if coords[0][0] > max_col
    max_col = coords[1][0] if coords[1][0] > max_col
  end

  map = Array.new(max_row+1) { Array.new(max_col+1, 0) }

  map
end

def build_map(directions)
  map = build_map_template(directions)

  directions.each do |coords|
    add_horizontal_line(map, coords) if coords[0][1] == coords[1][1]
    add_vertical_line(map, coords) if coords[0][0] == coords[1][0]
  end

  map
end

map = build_map(input)

p 'Part 1'
p @dangerous_points

@dangerous_points = 0

def add_diagonal_line(map, coords)
  t = coords[0][1] < coords[1][1] ? coords[0] : coords[1]
  b = coords[0][1] > coords[1][1] ? coords[0] : coords[1]

  col = t[0]

  (t[1]..b[1]).each do |row|
    @dangerous_points += 1 if map[row][col] == 1
    map[row][col] = map[row][col] + 1
    if col >= b[0]
      col -= 1
    else
      col += 1
    end
  end
end

def build_map(directions)
  map = build_map_template(directions)

  directions.each do |coords|
    if coords[0][1] == coords[1][1]
      add_horizontal_line(map, coords)
    elsif coords[0][0] == coords[1][0]
      add_vertical_line(map, coords)
    else
      add_diagonal_line(map, coords)
    end
  end

  map
end

map = build_map(input)

p 'Part 2'
p @dangerous_points
