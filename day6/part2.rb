require 'timeout'

map = File.open(ARGV[0]).readlines.map { |line| line.chomp.split('') }

starting_point = nil
map.each.with_index { |row, y| row.each.with_index { |v, x| starting_point = [x, y] if v == '^' } }

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

def track_route(map, starting_point)
  visited_with_direction = []
  current = starting_point
  direction = [0, -1]

  while true
    new_visited_with_direction = current + direction
    return :loop if visited_with_direction.include? new_visited_with_direction

    visited_with_direction << new_visited_with_direction

    next_step = add_points(current, direction)
    break if !on_map?(map, *next_step)

    if map[next_step[1]][next_step[0]] == '#'
      direction = rotate(*direction)
      next_step = add_points(current, direction)
      break if !on_map?(map, *next_step)
    end
    current = next_step
  end
  visited_with_direction
end

initial_route = track_route(map, starting_point)

loop_locations = Set.new
initial_route[0..-1].each.with_index do |(x, y, dx, dy), i|
  puts "Iteration #{i+1} of #{initial_route.length}"
    break if !on_map?(map, x+dx, y+dy)

    next_space = map[y+dy][x+dx]
    next if next_space == '#'

    map[y+dy][x+dx] = '#'

    # begin
      # Timeout::timeout(0.1) do
        route = track_route(map, starting_point)
        if route == :loop
          loop_locations << [x+dx,y+dy]
          puts "Found loop with obstruction at #{x+dx},#{y+dy}"
          map[y+dy][x+dx] = 'O'
          # map.each { |l| puts l.join('') }
        end
      # end
    # rescue Timeout::Error
      # puts "Timeout :("
    # end
    map[y+dy][x+dx] = next_space
end
# Brute force didn't work :(
puts loop_locations.length