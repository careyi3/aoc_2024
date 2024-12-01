# frozen_string_literal: true

module Day1
  module Part2
    def self.run(path, _)
      left = {}
      right = {}
      FileReader.for_each_line(path) do |line|
        l, r = line.split('   ').map(&:to_i)
        left[l] =
          if left[l].nil?
            1
          else
            left[l] + 1
          end
        right[r] =
          if right[r].nil?
            1
          else
            right[r] + 1
          end
      end
      sum = 0
      left.each do |l, count|
        sum += count * l * (right[l] || 0)
      end
      sum
    end
  end
end
