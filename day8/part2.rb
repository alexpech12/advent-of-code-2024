antenna_map = {}
bounds = [0,0]

lines = File.open(ARGV[0]).readlines
bounds[1] = lines.length
lines.each_with_index do |line, y|
  bounds[0] = line.length
  line.chomp.split('').each_with_index do |char, x|
    next if char == '.'

    antenna_map[char] = [] unless antenna_map.key? char

    antenna_map[char] << [x, y]
  end
end

def in_bounds?(bounds, x, y)
  x >= 0 && x < bounds[0] &&
    y >= 0 && y < bounds[1]
end

antinode_set = Set.new

antenna_map.each { |_k, locations|
  locations.combination(2).each { |a, b|
    puts "Finding antinodes for #{_k} at [#{a},#{b}]"
    diff = [(b[0]-a[0]), (b[1]-a[1])]

    next_antinode = a
    while in_bounds?(bounds, *next_antinode)
      antinode_set << next_antinode
      next_antinode = [next_antinode[0] + diff[0], next_antinode[1] + diff[1]]
    end
    next_antinode = a
    while in_bounds?(bounds, *next_antinode)
      antinode_set << next_antinode
      next_antinode = [next_antinode[0] - diff[0], next_antinode[1] - diff[1]]
    end
  }
}

puts antinode_set.size