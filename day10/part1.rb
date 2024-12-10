class Trailmap
  attr_reader :trailmap

  def initialize(trailmap)
    @trailmap = trailmap
  end

  def in_bounds?(x, y)
    x.between?(0, trailmap[0].length - 1) && y.between?(0, trailmap.length - 1)
  end

  def get(x, y)
    return nil unless in_bounds?(x, y)

    trailmap[y][x]
  end

  def neighbours(x, y)
    [
      [x-1,y],
      [x,y-1],
      [x+1,y],
      [x,y+1],
  ].select { |(x, y)| in_bounds?(x, y) }
  end

  def method_missing(m, *args, &block)
    trailmap.send(m, *args, &block)
  end
end

trailmap = Trailmap.new(
  File.open(ARGV[0]).readlines.map { |line|
    line.chomp.split('').map(&:to_i)
  }
)

trailheads = []
(0..(trailmap.length-1)).each do |y|
  (0..(trailmap[0].length-1)).each do |x|
    trailheads << [x,y] if trailmap[y][x] == 0
  end
end

puts trailheads.to_s

def find_paths(trailmap, location)
  # If location = 9, this is the end
  # Else, find neighbours one greater than the location value and return that path
  value = trailmap.get(*location)
  return { x: location[0], y: location[1] } if value == 9

  trailmap.neighbours(*location).map do |(x, y)|
    neighbour_value = trailmap.get(x, y)

    if neighbour_value == value + 1
      find_paths(trailmap, [x, y])
    else
      nil
    end
  end
end

result = trailheads.sum { |head| find_paths(trailmap, head).flatten.compact.uniq.length }
puts result