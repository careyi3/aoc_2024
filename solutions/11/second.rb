# frozen_string_literal: true

module Day11
  module Part2
    def self.run(path, _)
      nums = FileReader.read_file(path).split.map(&:to_i)

      stones = 0
      cache = {}
      nums.each do |num|
        stones += blink([num], 0, cache)
      end
      stones
    end

    def self.blink(nums, blinks, cache)
      key = "#{nums.join('-')}:#{blinks}"
      return cache[key] unless cache[key].nil?
      return 1 if blinks == 75

      new_nums = []
      nums.each do |num|
        if num.zero?
          new_nums << 1
        else
          if num.to_s.chars.length.odd?
            new_nums << (num * 2024)
          else
            left, right = num.to_s.chars.each_slice((num.to_s.chars.size / 2)).to_a
            left = left.join.to_i
            right = right.join.to_i
            new_nums << left
            new_nums << right
          end
        end
      end

      results = []
      new_nums.each do |num|
        results << blink([num], blinks + 1, cache)
      end

      cache[key] = results.sum

      results.sum
    end
  end
end
