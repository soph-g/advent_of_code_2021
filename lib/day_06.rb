input = File
  .open('inputs/06/day_06.txt')
  .readlines
  .map(&:chomp)
  .first
  .split(',')
  .map!(&:to_i)

# Part 1

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

p 'Part 1'
p spawn_fish(input, 80).count
