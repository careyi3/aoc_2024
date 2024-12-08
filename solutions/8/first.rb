# frozen_string_literal: true

module Day8
  module Part1
    def self.run(path, _)
      y_max = -1
      x_max = 0
      frequencies = {}
      FileReader.for_each_line_with_index(path) do |line, y|
        x_max = line.chars.length - 1
        line.chars.each_with_index do |char, x|
          next if char == '.'

          if frequencies[char].nil?
            frequencies[char] = [[x, y]]
          else
            frequencies[char] << [x, y]
          end
        end
        y_max += 1
      end

      results = {}
      frequencies.each do |freq, coords|
        results[freq] = []
        coords.combination(2).each do |pair|
          a, b = pair
          ax, ay = a
          bx, by = b

          diff_ax = ax - bx
          diff_ay = ay - by

          diff_bx = bx - ax
          diff_by = by - ay

          results[freq] << [[ax + (2 * diff_bx), ay + (2 * diff_by)], [bx + (2 * diff_ax), by + (2 * diff_ay)]]
        end
      end
      results.values.flatten(2).uniq.select { |coord| coord[0] >= 0 && coord[0] <= x_max && coord[1] >= 0 && coord[1] <= y_max }.count
    end
  end
end
