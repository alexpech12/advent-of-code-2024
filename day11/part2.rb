class StoneList
  attr_reader :stone_map

  def initialize
    @stone_map = {}
  end

  def add(stone)
    if stone_map.key? stone
      stone_map[stone] += 1
    else
      stone_map[stone] = 1
    end
  end

  def insert_values(map, value, amount)
    map[value] = 0 unless map.key? value

    map[value] += amount
  end

  def blink
    new_stone_map = {}
    stone_map.each do |value, amount|
      if value == '0'
        insert_values(new_stone_map, '1', amount)
      elsif value.length % 2 == 0
        insert_values(new_stone_map, value[0..(value.length/2-1)].to_i.to_s, amount)
        insert_values(new_stone_map, value[(value.length/2)..-1].to_i.to_s, amount)
      else
        insert_values(new_stone_map, (value.to_i * 2024).to_s, amount)
      end
    end
    @stone_map = new_stone_map
  end

  def length
    stone_map.sum { |value, amount| amount }
  end
end

stones = File.open(ARGV[0]).readlines.first.chomp.split(' ')

stone_list = StoneList.new
stones.each { |stone| stone_list.add(stone) }

75.times do
  stone_list.blink
end

puts stone_list.length