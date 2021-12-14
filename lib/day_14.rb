input = File
  .open('inputs/14/day_14.txt')
  .readlines
  .map(&:chomp)

template = input[0]
rules = input[2..-1].map { |rule| rule.split(' -> ') }.to_h

p 'Part 1 & 2'
counts = Hash.new(0)
pair_counts = Hash.new(0)

template.size.times do |i|
  counts[template[i]] += 1

  pair_counts[template[i, 2]] += 1 if rules[template[i, 2]]
end

40.times do
  tmp = Hash.new(0)
  pair_counts.each_pair do |s, c|
    insert = rules[s]
    counts[insert] += c

    tmp[s[0] + insert] += c
    tmp[insert + s[1]] += c
  end
  pair_counts = tmp
end

p counts.values.max - counts.values.min
