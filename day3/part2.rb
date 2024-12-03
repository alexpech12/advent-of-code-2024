input = File.open(ARGV[0]).readlines.join('')
matches = input.scan(/mul\([0-9]{1,3},[0-9]{1,3}\)|do\(\)|don't\(\)/)
sum = 0
doing = true
matches.each { |match|
  case match
  when "do()"
    doing = true
  when "don't()"
    doing = false
  else
    if doing
      a, b = match.scan(/\d+/).map(&:to_i)
      sum += a * b
    end
  end
}
puts sum