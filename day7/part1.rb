equations = File.open(ARGV[0]).readlines.map { |line| line.scan(/\d+/).map(&:to_i) }

def compute(values, operators)
  values[1..-1].each_with_index.inject(values[0]) { |result, (value, i)|
    if operators >> i & 1 == 1
      result *= value
    else
      result += value
    end
  }
end

result = equations.select { |answer, *values|
  operators = 0
  final_operator_combination = 2 ** (values.length-1) - 1
  (0..final_operator_combination).find { |operators|
    compute(values, operators) == answer
  }
}.map { |answer, *_v| answer }.sum

puts result