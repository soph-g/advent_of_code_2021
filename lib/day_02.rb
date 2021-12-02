input = File.open('inputs/day_02.txt').readlines.map(&:chomp)

# Part 1
depth = 0
position = 0

input.each do |instruction|
  instruction = instruction.split(' ')
  distance = instruction[1].to_i
  case instruction[0]
  when "forward"
    position += distance
  when "down"
    depth += distance
  when "up"
    depth -= distance
  end
end

p "Part 1"
p depth * position

# Part 2
depth = 0
position = 0
aim = 0

input.each do |instruction|
  instruction = instruction.split(' ')
  distance = instruction[1].to_i
  case instruction[0]
  when "forward"
    position += distance
    depth += (aim * distance)
  when "down"
    aim += distance
  when "up"
    aim -= distance
  end
end

p "Part 2"
p depth * position
