# frozen_string_literal: true

module Day10
  module Part2
    def self.run(path, _)
      map = {}
      start_points = []
      FileReader.for_each_line_with_index(path) do |line, y|
        line.chars.map(&:to_i).each_with_index do |val, x|
          key = "#{x}:#{y}"
          map[key] = val
          start_points << key if val.zero?
        end
      end

      score = 0
      start_points.each do |point|
        x, y = point.split(':').map(&:to_i)
        peaks = {}
        walk(map, x, y, 0, peaks)
        score += peaks.values.sum
      end
      score
    end

    def self.walk(map, x, y, height, peaks)
      if height == 9
        peaks["#{x}:#{y}"] =
          if peaks["#{x}:#{y}"].nil?
            1
          else
            peaks["#{x}:#{y}"] + 1
          end
        return peaks
      end

      dirs = [[1, 0], [0, 1], [-1, 0], [0, -1]]
      dirs.each do |dir|
        next_x = x + dir[0]
        next_y = y + dir[1]
        walk(map, next_x, next_y, height + 1, peaks) if map["#{next_x}:#{next_y}"] == height + 1
      end

      peaks
    end
  end
end
