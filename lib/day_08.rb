input = File
  .open('inputs/08/day_08.txt')
  .readlines
  .map(&:chomp)
  .map { |line| line.split(' | ')}
  .map { |arr| arr.map { |s| s.split(' ') } }

# digits = {
#   0 => 'abcefg',
#   1 => 'cf',
#   2 => 'acdeg',
#   3 => 'acdfg',
#   4 => 'bcdf',
#   5 => 'abdfg',
#   6 => 'abdefg',
#   7 => 'acf',
#   8 => 'abcdefg',
#   9 => 'abcdfg',
# }

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

=begin
 aaaa
b    c
b    c
 dddd
e    f
e    f
 gggg

digits = [abcefg, cf, acdfg, nil, bcdf, nil, abdefg, acf, abcdefg, abcdfg]
screen = [a, b, c, d, e, f, nil]

find 1, 4, 7 & 8
find the five char digits - 3 includes both digits from 1
find the six char digits - 6 does not include both digits from 1
in the remaining digits:
 - d is not present in 0 but is present in 2, 5 & 9
 - then can find 9
 - use 6 to identify 5 (only 1 char difference)

=end


@digit_map = {
  2 => 1,
  4 => 4,
  3 => 7,
  7 => 8,
}

def build_screen(digits)
   result = Array.new(10)

   digits.each do |digit|
     if @digit_map[digit.length]
       result[@digit_map[digit.length]] = digit
     end
   end

   five_chars = digits.select { |digit| digit.length == 5 }
   six_chars = digits.select { |digit| digit.length == 6 }

   five_chars.each do |digit|
     tmp = digit.split('')
     if tmp.include?(result[1][0]) && tmp.include?(result[1][1])
       result[3] = digit
       five_chars.delete(digit)
       break
     end
   end

   six_chars.each do |digit|
     tmp = digit.split('')
     next if tmp.include?(result[1][0]) && tmp.include?(result[1][1])

     result[6] = digit
     six_chars.delete(digit)
     break
   end

   key = result[4].delete(result[1])

   six_chars.each do |digit|
     tmp = digit.split('')
     if tmp.include?(key[0]) && tmp.include?(key[1])
       result[9] = digit
     else
       result[0] = digit
     end
   end

   five_chars.each do |digit|
     tmp = digit.split('')
     if tmp.include?(key[0]) && tmp.include?(key[1])
       result[5] = digit
     else
       result[2] = digit
     end
   end

   map = {}
   result.each_with_index do |n, i|
     map[n.split('').sort.join] = i.to_s
   end

   map
end

sum = 0

input.each do |arr|
  screen = build_screen(arr[0])
  digits = ''

  arr[1].each do |digit|
    digit = digit.split('').sort.join
    digits << screen[digit]
  end
  sum += digits.to_i
end

p 'Part 2'
p sum
