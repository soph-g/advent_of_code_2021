input = File
  .open('inputs/06/test.txt')
  .readlines
  .map(&:chomp)
  .first
  .split(',')
  .map!(&:to_i)

p 'Part 1'

def spawn_fish(fish, days)
  return fish if days == 0

  result = []
  new_fish = []

  fish.each do |day|
    if day == 0
      result << 6
      new_fish << 8
    else
      result << day - 1
    end
  end

  spawn_fish(result + new_fish, days-1)
end

p spawn_fish(input, 80).count

p 'Part 2'

def count_fish(fish)
  counts = Array.new(9, 0)
  fish.each { |day| counts[day] += 1 }

  counts
end

def spawn_fish(fish_counts, days)
  return fish_counts.reduce(:+) if days == 0

  new_fish_counts = Array.new(9, 0)

  fish_counts.each_with_index do |count, i|
    if i == 0
      new_fish_counts[8] += count
      new_fish_counts[6] += count
    else
      new_fish_counts[i-1] += count
    end
  end

  spawn_fish(new_fish_counts, days-1)
end

p spawn_fish(count_fish(input), 256)
