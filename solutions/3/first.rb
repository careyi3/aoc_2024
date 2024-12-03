# frozen_string_literal: true

module Day3
  module Part1
    def self.run(path, _)
      memory = FileReader.read_file(path)
      ops = memory.scan(/mul\(\d{1,3},\d{1,3}\)/)
      sum = 0
      ops.each do |op|
        l, r = op.scan(/\d{1,3}/).map(&:to_i)
        sum += (l * r)
      end
      sum
    end
  end
end
