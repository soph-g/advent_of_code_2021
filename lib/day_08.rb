input = File
  .open('inputs/08/day_08.txt')
  .readlines
  .map(&:chomp)
  .map { |line| line.split(' | ')}
  .map { |arr| arr.map { |s| s.split(' ') } }

digit_map = {
  2 => 1,
  4 => 4,
  3 => 7,
  7 => 8,
}

counts = Array.new(10, 0)

input.each do |lines|
  lines[1].each do |digit|
    next unless digit_map[digit.length]

    counts[digit_map[digit.length]] += 1
  end
end

p 'Part 1'
p counts.reduce(:+)

# Part 2, attempt 2

def decode_digits(digits)
  map = Array.new(10)
  digit_map = {
    1 => 2,
    4 => 4,
    7 => 3,
    8 => 7,
  }

  digit_map.each_pair do |digit, length|
    map[digit] = digits.select { |d| d.length == length }[0]
  end

  digits.select { |d| d.length == 6 }.each do |d|
    if d.delete(map[4]).length == 2
      map[9] = d
    elsif d.delete(map[1]).length == 5
      map[6] = d
    else
      map[0] = d
    end
  end

  digits.select { |d| d.length == 5 }.each do |d|
    if d.delete(map[1]).length == 3
      map[3] = d
    elsif d.delete(map[4]).length == 2
      map[5] = d
    else
      map[2] = d
    end
  end

  result = {}
  map.each_with_index do |n, i|
   result[n.split('').sort.join] = i.to_s
  end

  result
end

sum = 0

input.each do |arr|
  digits = decode_digits(arr[0])
  screen = ''

  arr[1].each do |digit|
    digit = digit.split('').sort.join
    screen << digits[digit]
  end
  sum += screen.to_i
end

p 'Part 2'
p sum
