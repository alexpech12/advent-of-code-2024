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

def safe_get(map, x, y)
  return nil unless y.between?(0, map.length-1) && x.between?(0, map[0].length-1)

  map[y][x]
end

def find_edges(map, region, side)
  edges = region[:points].select { |x, y|
    safe_get(map, x + side[0], y + side[1]) != region[:type]
  }

  sorted_edges = edges.sort { |(x1, y1), (x2, y2)|
    cx, cy = [x1 <=> x2, y1 <=> y2]
    if side[0] == 0 # Horizontal edges
      cy == 0 ? cx : cy
    else
      cx == 0 ? cy : cx
    end
  }

  continuous_edges = []
  current_edge = [sorted_edges.first, sorted_edges.first]
  sorted_edges[1..-1].each do |x, y|
    if current_edge[1] == [x - side[1].abs, y - side[0].abs]
      current_edge[1] = [x, y]
    else
      continuous_edges << current_edge
      current_edge = [[x, y],[x, y]]
    end
  end
  continuous_edges << current_edge
  continuous_edges
end

result = regions.map { |region|
  type = region[:type]

  perimeter = [[0, -1], [0, 1], [-1, 0], [1, 0]].map { |side|
    find_edges(map, region, side).length
  }.sum

  perimeter * region[:points].size
}.sum

puts result