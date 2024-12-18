# frozen_string_literal: true

require 'algorithms'

module Day18
  module Part1
    include Containers

    def self.run(path, type)
      limit = type == 'sample' ? 12 : 1024
      x_max = type == 'sample' ? 6 : 70
      y_max = type == 'sample' ? 6 : 70
      finish = type == 'sample' ? [6, 6] : [70, 70]
      byte = 0
      map = {}
      visited = {}
      heap = MinHeap.new
      heap.push(0, '0:0')
      (y_max + 1).times do |y|
        (x_max + 1).times do |x|
          if x == 0 && y == 0
            map["#{x}:#{y}"] = 0
            next
          end
          map["#{x}:#{y}"] = 1_000_000_000_000
        end
      end
      FileReader.for_each_line(path) do |line|
        break if byte == limit

        x, y = line.split(',').map(&:to_i)
        map.delete("#{x}:#{y}")

        byte += 1
      end

      loop do
        min_coord = heap.pop
        x, y = min_coord.split(':').map(&:to_i)
        key = "#{x}:#{y}"
        next if map[key].nil?

        check(heap, visited, map, x, y)
        break if finish == [x, y]
      end
      visited["#{finish[0]}:#{finish[1]}"]
    end

    def self.check(heap, visited, map, x, y)
      key = "#{x}:#{y}"
      visited[key] = map[key]

      [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |d|
        next_x = x + d[0]
        next_y = y + d[1]
        next_key = "#{next_x}:#{next_y}"
        next if map[next_key].nil?

        cost = 1

        next unless (map[key] + cost) < map[next_key]

        map[next_key] = (map[key] + cost)
        heap.push((map[key] + cost), next_key)
      end
      map.delete(key)
      nil
    end
  end
end
