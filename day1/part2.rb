input = File.open(ARGV[0]).readlines

a = []
b = []
input.each_with_index { |line, i| a[i], b[i] = line.scan(/(\d+)/).flatten.map(&:to_i) }
result = a.map { |x| x * b.count(x) }.sum
puts result
