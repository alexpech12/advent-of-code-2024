map = []
open_set = Set.new

File.open(ARGV[0]).readlines.each_with_index do |line, y|
  line.chomp.split('').each_with_index do |c, x|
    map[y] = [] if map[y].nil?
    map[y][x] = c

    open_set << [x,y]
  end
end


regions = []
until open_set.empty?
  x, y = open_set.first
  open_set.delete([x,y])
  type = map[y][x]
  region = { type: type, points: [[x,y]] }

  puts "Initialised region #{region}"
  edge_set = Set.new([[x,y]])
  until edge_set.empty?
    edge = edge_set.first
    edge_set.delete(edge)
    x, y = edge

    neighbours = [[-1,0],[0,-1],[1,0],[0,1]].map { |dx, dy| [x + dx, y + dy] }
    neighbours = neighbours.select { |x, y|
      y.between?(0, map.length-1) &&
      x.between?(0, map[0].length-1) &&
      open_set.include?([x,y])
    }
    neighbours.each { |x, y|
      if map[y][x] == type
        region[:points] << [x,y]
        open_set.delete([x,y])
        edge_set << [x,y]
      end
    }
  end
  regions << region
end

result = regions.map { |region|
  perimeter = region[:points].map { |x, y|
    [[-1,0],[0,-1],[1,0],[0,1]].select { |dx, dy|
      mx, my = [x + dx, y + dy]

      if my.between?(0, map.length-1) && mx.between?(0, map[0].length-1)
        map[my][mx] != region[:type]
      else
        true
      end
    }.length
  }.sum

  perimeter * region[:points].size
}.sum

puts result