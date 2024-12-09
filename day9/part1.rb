input = File.open(ARGV[0]).readlines[0].chomp
EMPTY = '.'
disk = []
input.chars.each_slice(2).with_index do |(mem, free), i|
  mem.to_i.times { disk << i }
  free.to_i.times { disk << EMPTY }
end
puts disk.join('')

block_count = disk.count { |v| v != EMPTY }

i_forward = 0
i_back = disk.length - 1
while true
  i_back -= 1 until disk[i_back] != EMPTY

  i_forward += 1 until disk[i_forward] == EMPTY

  break if i_forward >= block_count

  v = disk[i_back]
  disk[i_back] = EMPTY
  disk[i_forward] = v
end

puts disk.to_s

result = (disk - [EMPTY]).map.with_index { |d, i|
  d * i
}.sum
puts result