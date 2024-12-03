# frozen_string_literal: true

module Day3
  module Part2
    def self.run(path, _)
      memory = FileReader.read_file(path)
      ops = memory.scan(/(?=(mul\(\d{1,3},\d{1,3}\)|don't\(\)|do\(\)))/).flatten
      sum = 0
      enabled = true
      ops.each do |op|
        if op[0] == 'd'
          enabled = (op == 'do()')
          next
        end

        next unless enabled

        l, r = op.scan(/\d{1,3}/).flatten.map(&:to_i)
        sum += (l * r)
      end
      sum
    end
  end
end
