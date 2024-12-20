# frozen_string_literal: true

require 'algorithms'

module Day20
  module Part1
    include Containers

    def self.run(path, _)
      heap = MinHeap.new
      map = {}
      visited = {}
      finish = []
      FileReader.for_each_line_with_index(path) do |line, y|
        line.chars.each_with_index do |char, x|
          next if char == '#'

          if char == 'S'
            heap.push(0, "#{x}:#{y}")
            map["#{x}:#{y}"] = 0
            next
          end
          finish = [x, y] if char == 'E'
          map["#{x}:#{y}"] = 1_000_000_000_000
        end
      end

      loop do
        min_coord = heap.pop
        break if min_coord.nil?

        x, y = min_coord.split(':').map(&:to_i)
        key = "#{x}:#{y}"
        next if map[key].nil?

        check(heap, visited, map, x, y)
        break if finish == [x, y]
      end

      cheats = []
      visited.each do |coord, _|
        x, y = coord.split(':').map(&:to_i)
        key = "#{x}:#{y}"
        [[0, 2], [0, -2], [2, 0], [-2, 0]].each do |d|
          next_x = x + d[0]
          next_y = y + d[1]
          next_key = "#{next_x}:#{next_y}"
          next if visited[next_key].nil? || (visited[key] >= visited[next_key])

          cheats << {
            from: key,
            to: next_key
          }
        end
      end

      savings = {}
      cheats.each do |cheat|
        diff = visited[cheat[:to]] - visited[cheat[:from]]
        next if diff == 2

        saving = diff - 2
        if savings[saving].nil?
          savings[saving] = 1
        else
          savings[saving] += 1
        end
      end

      count = 0
      savings.each do |saving, num|
        count += num if saving >= 100
      end
      count
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
