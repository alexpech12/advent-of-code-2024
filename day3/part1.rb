input = File.open(ARGV[0]).readlines.join('')
matches = input.scan(/mul\([0-9]{1,3},[0-9]{1,3}\)/)
result = matches.sum { |match|
  a, b = match.scan(/\d+/).map(&:to_i)
  a * b
}
puts result