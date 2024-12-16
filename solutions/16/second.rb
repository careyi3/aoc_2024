# frozen_string_literal: true

module Day16
  module Part2
    def self.run(path, _)
      unvisited = {}
      visited = {}
      finish = []
      start = []
      dirs = [[-1, 0], [0, -1], [1, 0], [0, 1]]
      map = {}
      FileReader.for_each_line_with_index(path) do |line, y|
        line.chars.each_with_index do |char, x|
          next if char == '#'

          map["#{x}:#{y}"] = char

          4.times do |i|
            unvisited["#{x}:#{y}:#{i}"] = 1_000_000_000
          end
          if char == 'S'
            unvisited["#{x}:#{y}:2"] = 0
            start = [x, y]
          end
          finish = [x, y] if char == 'E'
        end
      end

      while unvisited.count > 0
        min_coord, min_val = unvisited.min_by { |_, val| val }
        break if min_val == 1_000_000_000

        x, y, dir = min_coord.split(':').map(&:to_i)
        check(unvisited, visited, dirs, dir, x, y)
      end

      scores = []
      4.times do |i|
        scores << visited["#{finish[0]}:#{finish[1]}:#{i}"]
      end
      shortest_path = scores.compact.min

      hash = {}
      walk(map, dirs, 2, start[0], start[1], 0, visited, shortest_path, [], hash)

      hash.count
    end

    def self.check(unvisited, visited, dirs, dir, x, y)
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

    def self.walk(map, dirs, dir, x, y, score, shortest_paths, shortest_path, points, hash)
      key = "#{x}:#{y}"

      points << key
      return if score > shortest_path
      return if score > shortest_paths["#{x}:#{y}:#{dir}"]

      if map[key] == 'E'
        points.each do |point|
          hash[point] =
            if hash[point].nil?
              1
            else
              hash[point] + 1
            end
        end
        return
      end

      dirs.each_with_index do |_, d|
        next_x = x + dirs[d][0]
        next_y = y + dirs[d][1]
        next_key = "#{next_x}:#{next_y}"
        next if map[next_key].nil?

        cost = 1
        cost += 1000 if ([0, 2].include?(d) && [1, 3].include?(dir)) || ([1, 3].include?(d) && [0, 2].include?(dir))
        cost += 2000 if (d == 0 && dir == 2) || (d == 1 && dir == 3) || (d == 2 && dir == 0) || (d == 3 && dir == 1)

        walk(map, dirs, d, next_x, next_y, score + cost, shortest_paths, shortest_path, points.clone, hash)
      end
      nil
    end
  end
end
