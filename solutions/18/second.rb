# frozen_string_literal: true

require 'algorithms'

module Day18
  module Part2
    include Containers

    def self.run(path, type)
      x_max = type == 'sample' ? 6 : 70
      y_max = type == 'sample' ? 6 : 70
      finish = type == 'sample' ? [6, 6] : [70, 70]
      map = {}

      (y_max + 1).times do |y|
        (x_max + 1).times do |x|
          if x == 0 && y == 0
            map["#{x}:#{y}"] = 0
            next
          end
          map["#{x}:#{y}"] = 1_000_000_000_000
        end
      end
      bytes = []
      FileReader.for_each_line(path) do |line|
        bytes << line.split(',').map(&:to_i)
      end

      2936.times do |i| # Last successful one, found by manually binary searching (took about 30 seconds to test a handful of numbers to find this)
        map.delete("#{bytes[i][0]}:#{bytes[i][1]}")
      end

      simulate(finish, map)
    end

    def self.simulate(finish, map)
      heap = MinHeap.new
      heap.push(0, '0:0')
      visited = {}
      loop do
        min_coord = heap.pop
        return if min_coord.nil?

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
