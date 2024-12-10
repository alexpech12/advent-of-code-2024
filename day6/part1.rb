map = File.open(ARGV[0]).readlines.map { |line| line.chomp.split('') }

starting_point = nil
map.each.with_index { |row, y| row.each.with_index { |v, x| starting_point = [x, y] if v == '^' } }

visited = Set.new
current = starting_point
direction = [0, -1]

def add_points(a, b)
  [a[0] + b[0], a[1] + b[1]]
end

def rotate(x, y)
  case [x, y]
  when [0, -1]
    [1, 0]
  when [1, 0]
    [0, 1]
  when [0, 1]
    [-1, 0]
  when [-1, 0]
    [0, -1]
  else
    raise ArgumentError
  end
end

def on_map?(map, x, y)
  x >= 0 && y >= 0 && x < map[0].length && y < map.length
end

while true
  visited << current
  next_step = add_points(current, direction)
  break if !on_map?(map, *next_step)

  if map[next_step[1]][next_step[0]] == '#'
    direction = rotate(*direction)
    next_step = add_points(current, direction)
    break if !on_map?(map, *next_step)
  end
  current = next_step
end

puts visited.length