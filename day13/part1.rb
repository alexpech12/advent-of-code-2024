File.open(ARGV[0]).readlines.each_slice(4) do |(a, b, c, _)|
  ax, ay = a.scan(/\d+/).map(&:to_i)
  bx, by = b.scan(/\d+/).map(&:to_i)
  cx, cy = c.scan(/\d+/).map(&:to_i)

  # Solve A * ax + B * bx = cx
  gcdx = ax.gcd(bx)
  gcdy = ay.gcd(by)

  puts "GCDX(#{ax}, #{bx}) = #{gcdx}"
  puts "GCDY(#{ay}, #{by}) = #{gcdy}"
  if cx % gcdx != 0 || cy % gcdy != 0
    puts "No solution exists!"
  else
    puts "Solution exists!"

    # TODO: Clamp max presses to 100

    solutions = (0..((cx / ax) + 1)).map do |a_presses|
      # puts "Testing #{a_presses} presses of A"

      # If we push a this many times, how many times do we need to press b?
      initial_y = a_presses * ay
      remaining_b = cy - initial_y

      # puts "After pressing A this many times, y will be #{initial_y}"
      # puts "This leaves #{remaining_b} y to fill with B presses"

      next unless remaining_b % by == 0

      b_presses = remaining_b / by

      # puts "by is #{by} so this will take #{b_presses} presses of B"

      # Check
      if a_presses * ax + b_presses * bx == cx && a_presses * ay + b_presses * by == cy
        [a_presses, b_presses]
      else
        puts "We thought we found a solution with #{[a_presses, b_presses]} but we didn't :("
        nil
      end
    end.compact
    puts solutions.to_s
    break
  end

  # General solution
  # A - k (bx / gcdx) = A0
end

