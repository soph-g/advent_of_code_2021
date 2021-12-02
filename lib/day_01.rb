input = File.open('inputs/day_01.txt').readlines.map(&:chomp).map(&:to_i)
count = 0
i = input.length - 2
current = input[i-1..i+1].reduce(:+)

while i > 2 do
  prev = current
  current = current - input[i + 1] + input[i - 2]
  i -= 1

  count += 1 if prev > current
end

p count
