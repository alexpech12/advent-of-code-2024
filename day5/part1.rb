lines = File.open(ARGV[0]).readlines
break_index = lines.index("\n")
rules = lines[0..(break_index-1)].map { |line| line.scan(/\d+/).map(&:to_i) }
updates = lines[break_index+1..].map { |line| line.scan(/\d+/).map(&:to_i) }

correct_updates = updates.select { |update|
  rules.select { |a, b| update.include?(a) && update.include?(b) }
       .all? { |a, b| update.index(a) < update.index(b) }
}

result = correct_updates.sum { |update| update[update.length/2] }
puts result