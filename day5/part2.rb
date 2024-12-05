lines = File.open(ARGV[0]).readlines
break_index = lines.index("\n")
rules = lines[0..(break_index-1)].map { |line| line.scan(/\d+/).map(&:to_i) }
updates = lines[break_index+1..].map { |line| line.scan(/\d+/).map(&:to_i) }

incorrect_updates = updates.select { |update|
  rules.select { |a, b| update.include?(a) && update.include?(b) }
    .any? { |a, b| !(update.index(a) < update.index(b)) }
}

fixed_updates = incorrect_updates.map { |update|
  relevant_rules = rules.select { |a, b| update.include?(a) && update.include?(b) }
  update.sort { |a, b|
    if relevant_rules.include? [a, b]
      -1
    elsif relevant_rules.include? [b, a]
      1
    else
      0
    end
  }
}
result = fixed_updates.sum { |update| update[update.length/2] }
puts result