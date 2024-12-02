reports = File.open(ARGV[0]).readlines.map { |line| line.scan(/\d+/).map(&:to_i) }
result = reports.select { |r|
  (r.sort == r || r.sort.reverse == r) &&
  r[0..-2].map.with_index{ |v, i| (v-r[i+1]).abs}.all? { |diff| diff.between?(1,3) }
 }.count
 puts result