input = File
  .open('inputs/10/day_10.txt')
  .readlines
  .map(&:chomp)

syntax_scores = {
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25137,
}

pairs = {
  ')' => '(',
  ']' => '[',
  '}' => '{',
  '>' => '<',
}

score = 0

input.each do |s|
  stack = []

  s.size.times do |i|
    bracket = s[i]

    if pairs.values.include?(bracket)
      stack << bracket
    elsif pairs[bracket] == stack[-1]
      stack.pop
    else
      score += syntax_scores[bracket]
      break
    end
  end
end

p 'Part 1'
p score

# Part 2

p 'Part 2'

autocomplete_scores = {
  '(' => 1,
  '[' => 2,
  '{' => 3,
  '<' => 4,
}

scores = []

input.each do |s|
  stack = []
  score = 0

  s.size.times do |i|
    bracket = s[i]

    if autocomplete_scores.keys.include?(bracket)
      stack << bracket
    elsif pairs[bracket] == stack[-1]
      stack.pop
    else
      stack = []
      break
    end
  end

  if !stack.empty?
    while !stack.empty?
      score *= 5
      score += autocomplete_scores[stack.pop]
    end

    scores << score
    score = 0
  end
end

p scores.sort[scores.size / 2 ]
