input = File.open(ARGV[0], 'r').readlines
input_array = input.map { |line| line.chomp.split('') }

count_horizontal = (0..(input_array.length-1)).sum { |y|
  (0..(input_array[y].length-4)).count { |x|
    diag = input_array[y][x] + input_array[y][x+1] + input_array[y][x+2] + input_array[y][x+3]
    diag == "XMAS" || diag == "SAMX"
  }
}

count_vertical= (0..(input_array.length-4)).sum { |y|
  (0..(input_array[y].length-1)).count { |x|
    diag = input_array[y][x] + input_array[y+1][x] + input_array[y+2][x] + input_array[y+3][x]
    diag == "XMAS" || diag == "SAMX"
  }
}

count_diag_a = (0..(input_array.length-4)).sum { |y|
  (0..(input_array[y].length-4)).count { |x|
    diag = input_array[y][x] + input_array[y+1][x+1] + input_array[y+2][x+2] + input_array[y+3][x+3]
    diag == "XMAS" || diag == "SAMX"
  }
}
count_diag_b = (0..(input_array.length-4)).sum { |y|
  (3..(input_array[y].length-1)).count { |x|
    diag = input_array[y][x] + input_array[y+1][x-1] + input_array[y+2][x-2] + input_array[y+3][x-3]
    diag == "XMAS" || diag == "SAMX"
  }
}


puts count_horizontal
puts count_vertical
puts count_diag_a
puts count_diag_b
puts count_horizontal + count_vertical + count_diag_a + count_diag_b