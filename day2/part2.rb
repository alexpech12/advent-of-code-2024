def safe?(report)
  (report.sort == report || report.sort.reverse == report) &&
    report[0..-2].map.with_index{ |v, i| (v - report[i+1]).abs}.all? { |diff| diff.between?(1,3) }
end

reports = File.open(ARGV[0]).readlines.map { |line| line.scan(/\d+/).map(&:to_i) }
result = reports.select { |r|
  next true if safe?(r)
  (0..(r.length-1)).any? { |except_index|
    rmod = r.dup.tap { |a| a.delete_at(except_index) }
    safe?(rmod)
  }

 }.count
 puts result