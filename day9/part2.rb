input = File.open(ARGV[0]).readlines[0].chomp
EMPTY = '.'
disk = []
mem_map = []
free_map = []
cursor = 0
input.chars.each_slice(2).with_index do |(mem, free), i|
  mem.to_i.times { disk << i }
  free.to_i.times { disk << EMPTY }

  mem_map << { id: i, location: cursor, size: mem.to_i}
  cursor += mem.to_i
  free_map << { location: cursor, size: free.to_i }
  cursor += free.to_i
end
puts disk.join('')


mem_map.reverse.each do |mem|
  free_index = free_map.index { |free| free[:size] >= mem[:size] }
  next if free_index.nil?

  free_block = free_map[free_index]

  next if free_block[:location] > mem[:location]

  (free_block[:location]..(free_block[:location] + mem[:size] - 1)).each do |i|
    disk[i] = mem[:id]
  end
  (mem[:location]..(mem[:location] + mem[:size] - 1)).each do |i|
    disk[i] = EMPTY
  end

  free_map[free_index][:size] -= mem[:size]
  free_map[free_index][:location] += mem[:size]

  if free_map[free_index][:size] == 0
    free_map.delete(free_index)
  end
end

result = disk.map.with_index { |d, i|
  d == EMPTY ? 0 : d * i
}.sum
puts result