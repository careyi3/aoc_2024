# frozen_string_literal: true

module Day12
  module Part1
    def self.run(path, _)
      map = {}
      FileReader.for_each_line_with_index(path) do |line, y|
        line.chars.each_with_index do |type, x|
          map["#{x}:#{y}"] = { type:, visited: false }
        end
      end

      regions = {}
      region_id = 0
      map.each do |key, value|
        next if value[:visited]

        x, y = key.split(':').map(&:to_i)
        area, perimeter = walk(map, x, y, [0, 0])
        regions[region_id] = { area:, perimeter:, type: value[:type] }
        region_id += 1
      end

      price = 0
      regions.each_value do |val|
        price += (val[:area] * val[:perimeter])
      end
      price
    end

    def self.walk(map, x, y, tracking)
      key = "#{x}:#{y}"
      type = map[key][:type]

      map[key][:visited] = true
      tracking[0] += 1

      dirs = [[0, 1], [1, 0], [0, -1], [-1, 0]]
      dirs.each do |dir|
        next_key = "#{x + dir[0]}:#{y + dir[1]}"
        next_type = map[next_key][:type] unless map[next_key].nil?

        if next_type != type
          tracking[1] += 1
          next
        end
        next if map[next_key].nil? || map[next_key][:visited]

        tracking = walk(map, x + dir[0], y + dir[1], tracking)
      end

      tracking
    end
  end
end
