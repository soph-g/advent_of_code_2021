input = File
  .open('inputs/14/day_14.txt')
  .readlines
  .map(&:chomp)

template = input[0]
rules = input[2..-1].map { |rule| rule.split(' -> ') }.to_h

p 'Part 1'
counts = Hash.new(0)
pair_counts = Hash.new(0)

template.size.times do |i|
  counts[template[i]] += 1

  pair_counts[template[i, 2]] += 1 if rules[template[i, 2]]
end

# p template
# p counts
# p pair_counts

10.times do
  tmp = Hash.new(0)
  pair_counts.each_pair do |s, c|
    insert = rules[s]
    counts[insert] += c

    left = s[0] + insert
    right = insert + s[1]
    tmp[left] += c
    tmp[right] += c
  end
  pair_counts = tmp
end

# p pair_counts
p counts.values.max - counts.values.min

# 10.times do
#   output = ''
#   result.size.times do |i|
#     output << result[i]
#
#     if rules[result[i, 2]]
#       output << rules[result[i, 2]]
#       counts[rules[result[i, 2]]] += 1
#     end
#   end
#   result = output
# end
