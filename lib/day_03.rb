input = File.open('inputs/day_03.txt').readlines.map(&:chomp)

# Part 1
zeroes = Array.new(input[0].length, 0)
ones = Array.new(input[0].length, 0)
gamma_rate = ''
eplison_rate = ''

input.each do |s|
  s.length.times do |i|
    if s[i] == '0'
      zeroes[i] += 1
    else
      ones[i] += 1
    end
  end
end

zeroes.each_with_index do |count, i|
  if zeroes[i] > ones[i]
    gamma_rate += '0'
    eplison_rate += '1'
  else
    gamma_rate += '1'
    eplison_rate += '0'
  end
end

p 'Part 1'
p gamma_rate.to_i(2) * eplison_rate.to_i(2)

# Part 2
oxygen_generator_rating = input.dup
co2_scrubber_rating = input.dup

oxygen_generator_rating.first.length.times do |i|
  break if oxygen_generator_rating.length == 1
  counts = [0, 0]
  oxygen_generator_rating.each do |s|
    counts[s[i].to_i] += 1
  end
  selector = counts[0] > counts[1] ? '0' : '1'
  oxygen_generator_rating.select! { |s| s[i] == selector }
end

co2_scrubber_rating.first.length.times do |i|
  break if co2_scrubber_rating.length == 1
  counts = [0, 0]
  co2_scrubber_rating.each do |s|
    counts[s[i].to_i] += 1
  end
  selector = counts[0] <= counts[1] ? '0' : '1'
  co2_scrubber_rating.select! { |s| s[i] == selector }
end

p 'Part 2'
p oxygen_generator_rating.first.to_i(2) * co2_scrubber_rating.first.to_i(2)
