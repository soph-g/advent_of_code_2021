input = File
  .open('inputs/07/day_07.txt')
  .readlines
  .map(&:chomp)
  .first
  .split(',')
  .map!(&:to_i)

positions = input.tally.sort.to_h

=begin
Make a range using the min key and max key.
keep track of the least possible fuel usage (starting at inifinity)
For each possible position, calculate how much fuel it would cost to move all the crabs to that position:
- iterate over the hash
- if the key matches the current position, skip
- otherwise find the difference between the min & max posiitions

=end
p 'Day 1'
min_fuel = Float::INFINITY

(0..positions.keys.max).each do |i|
  fuel = 0
  positions.each_pair do |position, crabs|
    next if crabs == 0
    fuel += ((position - i).abs * crabs)
    break if fuel > min_fuel
  end
  break if fuel > min_fuel
  min_fuel = fuel if fuel < min_fuel
end

p min_fuel

p 'Day 2'
counts = Array.new(positions.keys.max + 1, 0)
min_fuel = Float::INFINITY

(0..positions.keys.max).each do |i|
  fuel = 0
  positions.each_pair do |position, crabs|
    next if crabs == 0
    move = (position - i).abs

    next if move == 0

    (1..move).each do |x|
      fuel += x * crabs
      break if fuel > min_fuel
    end
  end
  break if fuel > min_fuel
  min_fuel = fuel if fuel < min_fuel
end
p min_fuel
