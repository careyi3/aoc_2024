# frozen_string_literal: true

module Day6
  module Part1
    def self.run(path, _)
      start_x = 0
      start_y = 0
      map = {}
      dirs = [
        [0, -1],
        [1, 0],
        [0, 1],
        [-1, 0]
      ]
      current_dir = 0
      y_max = -1
      x_max = 0
      FileReader.for_each_line_with_index(path) do |line, y|
        x_max = line.length - 1
        line.chars.each_with_index do |char, x|
          if char == '^'
            start_x = x
            start_y = y
            next
          end

          map["#{x}:#{y}"] = char if char == '#'
        end
        y_max += 1
      end

      map = step(map, dirs, x_max, y_max, start_x, start_y, current_dir)
      map.values.tally['X']
    end

    def self.step(map, dirs, x_max, y_max, x, y, dir)
      return map if x.negative? || y.negative? || x > x_max || y > y_max

      map["#{x}:#{y}"] = 'X'

      next_x = x + dirs[dir][0]
      next_y = y + dirs[dir][1]
      while map["#{next_x}:#{next_y}"] == '#'
        dir = (dir + 1) % 4
        next_x = x + dirs[dir][0]
        next_y = y + dirs[dir][1]
      end

      step(map, dirs, x_max, y_max, next_x, next_y, dir)
    end
  end
end
