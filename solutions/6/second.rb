# frozen_string_literal: true

module Day6
  module Part2
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

          map["#{x}:#{y}"] = { symbol: char } if char == '#'
        end
        y_max += 1
      end

      original_map = map.clone
      step(map, dirs, x_max, y_max, start_x, start_y, 0)
      loop_count = 0
      map.each do |key, value|
        next if key == "#{start_x}:#{start_y}"
        next unless value[:symbol] == 'X'

        new_map = original_map.clone
        new_map[key] = { symbol: '#' }
        loop_count += 1 if step(new_map, dirs, x_max, y_max, start_x, start_y, 0)
      end
      loop_count
    end

    def self.step(map, dirs, x_max, y_max, x, y, dir)
      return false if x.negative? || y.negative? || x > x_max || y > y_max
      return true if !map["#{x}:#{y}"].nil? && map["#{x}:#{y}"][:dir] == dir

      map["#{x}:#{y}"] = { symbol: 'X', dir: }

      next_x = x + dirs[dir][0]
      next_y = y + dirs[dir][1]
      while !map["#{next_x}:#{next_y}"].nil? && map["#{next_x}:#{next_y}"][:symbol] == '#'
        dir = (dir + 1) % 4
        next_x = x + dirs[dir][0]
        next_y = y + dirs[dir][1]
      end

      step(map, dirs, x_max, y_max, next_x, next_y, dir)
    end
  end
end
