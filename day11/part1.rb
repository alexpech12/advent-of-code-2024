stones = File.open(ARGV[0]).readlines.first.chomp.split(' ')

blinks = 25
blinks.times do
  new_stones = []
  stones.each { |stone|
    if stone == '0'
      new_stones << '1'
    elsif stone.length % 2 == 0
      new_stones << stone[0..(stone.length/2-1)].to_i.to_s
      new_stones << stone[(stone.length/2)..-1].to_i.to_s
    else
      new_stones << (stone.to_i * 2024).to_s
    end
  }
  stones = new_stones
end
puts stones.length
