# frozen_string_literal: true

module Day13
  module Part1
    def self.run(path, _)
      machines = {}
      machine_id = 0
      FileReader.for_each_line_with_index(path) do |line, idx|
        machines[machine_id] = {} if machines[machine_id].nil?
        if line == ''
          machine_id += 1
          next
        end

        if (idx % 4).zero?
          ax, ay = line.scan(/\d{1,3}/).map(&:to_i)
          machines[machine_id][:ax] = ax
          machines[machine_id][:ay] = ay
          next
        end

        if idx % 4 == 1
          bx, by = line.scan(/\d{1,3}/).map(&:to_i)
          machines[machine_id][:bx] = bx
          machines[machine_id][:by] = by
          next
        end

        if idx % 4 == 2
          x, y = line.scan(/\d{1,9}/).map(&:to_i)
          machines[machine_id][:x] = x
          machines[machine_id][:y] = y
        end
      end

      total = 0
      machines.each do |_, machine|
        ax = machine[:ax]
        ay = machine[:ay]
        x = machine[:x]
        bx = machine[:bx]
        by = machine[:by]
        y = machine[:y]

        b = 1.0 * ((ax * y) - (ay * x)) / ((by * ax) - (ay * bx))
        a = 1.0 * (x - (bx * b)) / ax
        score = (3 * a) + b
        machine[:score] = score
        total += score.to_i if (score % 1).zero?
      end
      total
    end
  end
end
