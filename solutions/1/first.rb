# frozen_string_literal: true

module Day1
  module Part1
    def self.run(path, _)
      left = []
      right = []
      len = 0
      FileReader.for_each_line(path) do |line|
        l, r = line.split('   ').map(&:to_i)
        left << l
        right << r
        len += 1
      end
      left = left.sort
      right = right.sort
      diffs = []
      len.times do |idx|
        diff = left[idx] - right[idx]
        diff = (-1 * diff) if diff.negative?
        diffs << diff
      end
      diffs.sum
    end
  end
end
