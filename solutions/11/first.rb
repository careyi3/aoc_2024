# frozen_string_literal: true

module Day11
  module Part1
    def self.run(path, _)
      nums = FileReader.read_file(path).split.map(&:to_i)

      25.times do
        nums = blink(nums)
      end

      nums.count
    end

    def self.blink(nums)
      new_nums = []
      nums.each do |num|
        if num.zero?
          new_nums << 1
          next
        end
        if num.to_s.chars.length.odd?
          new_nums << (num *= 2024)
        else
          left, right = num.to_s.chars.each_slice((num.to_s.chars.size / 2)).to_a
          left = left.join.to_i
          right = right.join.to_i
          new_nums << left
          new_nums << right
        end
      end
      new_nums
    end
  end
end
