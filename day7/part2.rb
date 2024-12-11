equations = File.open(ARGV[0]).readlines.map { |line| line.scan(/\d+/).map(&:to_i) }

def compute(values, operators)
  values[1..-1].each_with_index.inject(values[0]) { |result, (value, i)|
    if operators[i] == '*'
      result *= value
    elsif operators[i] == '+'
      result += value
    else
      (result.to_s + value.to_s).to_i
    end
  }
end

operator_values = ['+', '*', '|']
result = equations.select { |answer, *values|
  operator_values.repeated_permutation(values.length-1).find { |operators|
    if compute(values, operators) == answer
      puts "Found! - #{values}, #{operators} = #{answer}"
      true
    else
      false
    end
  }
}.map { |answer, *_v| answer }.sum

puts result