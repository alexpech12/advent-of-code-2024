input = File.open(ARGV[0], 'r').readlines
input_array = input.map { |line| line.chomp.split('') }

count_mas = (1..(input_array.length-2)).sum { |y|
  (1..(input_array[y].length-2)).count { |x|
    mas_a = input_array[y-1][x-1] + input_array[y][x] + input_array[y+1][x+1]
    mas_b = input_array[y+1][x-1] + input_array[y][x] + input_array[y-1][x+1]
    (mas_a == "MAS" || mas_a == "SAM") && (mas_b == "MAS" || mas_b == "SAM")
  }
}


puts count_mas