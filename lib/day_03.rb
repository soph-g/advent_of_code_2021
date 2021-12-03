input = File.open('inputs/test_03.txt').readlines.map(&:chomp)

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

zeroes.length.times do |i|
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
def find_binary_string(strings, filter_by)
  strings.first.length.times do |i|
    break if strings.length == 1

    counts = [0, 0]
    strings.each { |s| counts[s[i].to_i] += 1 }
    max = counts[0] > counts[1] ? '0' : '1'

    strings.select! do |s|
      if filter_by == :max
        s[i] == max
      else
        s[i] != max
      end
    end
  end

  strings.first
end

oxygen_generator_rating = find_binary_string(input.dup, :max)
co2_scrubber_rating = find_binary_string(input.dup, :min)

p 'Part 2'
p oxygen_generator_rating.to_i(2) * co2_scrubber_rating.to_i(2)
