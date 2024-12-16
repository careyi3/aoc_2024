# frozen_string_literal: true

module Day16
  module Part1
    def self.run(path, _)
      unvisited = {}
      visited = {}
      finish = []
      dirs = [[-1, 0], [0, -1], [1, 0], [0, 1]]
      FileReader.for_each_line_with_index(path) do |line, y|
        line.chars.each_with_index do |char, x|
          next if char == '#'

          4.times do |i|
            unvisited["#{x}:#{y}:#{i}"] = 1_000_000_000
          end
          unvisited["#{x}:#{y}:2"] = 0 if char == 'S'
          finish = [x, y] if char == 'E'
        end
      end

      while unvisited.count > 0
        min_coord, min_val = unvisited.min_by { |_, val| val }
        break if min_val == 1_000_000_000

        x, y, dir = min_coord.split(':').map(&:to_i)
        walk(unvisited, visited, dirs, dir, x, y)
      end

      scores = []
      4.times do |i|
        scores << visited["#{finish[0]}:#{finish[1]}:#{i}"]
      end
      scores.compact.min
    end

    def self.walk(unvisited, visited, dirs, dir, x, y)
      key = "#{x}:#{y}:#{dir}"
      visited[key] = unvisited[key]

      dirs.each_with_index do |_, d|
        next_x = x + dirs[d][0]
        next_y = y + dirs[d][1]
        next_key = "#{next_x}:#{next_y}:#{d}"
        next if unvisited[next_key].nil?

        cost = 1
        cost += 1000 if ([0, 2].include?(d) && [1, 3].include?(dir)) || ([1, 3].include?(d) && [0, 2].include?(dir))
        cost += 2000 if (d == 0 && dir == 2) || (d == 1 && dir == 3) || (d == 2 && dir == 0) || (d == 3 && dir == 1)

        unvisited[next_key] = (unvisited[key] + cost) if (unvisited[key] + cost) < unvisited[next_key]
      end
      unvisited.delete(key)
      nil
    end
  end
end
