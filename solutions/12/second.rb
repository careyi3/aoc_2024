# frozen_string_literal: true

module Day12
  module Part2
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
        area, perimeter, perimeter_points = walk(map, x, y, [0, 0, []])
        regions[region_id] = { area:, perimeter:, perimeter_points:, type: value[:type] }
        region_id += 1
      end

      regions.each do |_, data|
        side_count = 0
        side_map = data[:perimeter_points].group_by { |x| x[2] }
        4.times do |dir|
          side_count +=
            if [1, 3].include?(dir)
              count_sides(side_map, dir, 0, 1)
            else
              count_sides(side_map, dir, 1, 0)
            end
        end
        data[:side_count] = side_count
      end

      price = 0
      regions.each_value do |val|
        price += (val[:area] * val[:side_count])
      end
      price
    end

    def self.count_sides(side_map, dir, group_by, sort_by)
      side_count = 0
      side_map[dir].group_by { |a| a[group_by] }.each do |_, points|
        last_value = nil
        points.sort_by { |b| b[sort_by] }.each_with_index do |sorted, idx|
          if idx.zero?
            last_value = sorted[sort_by]
            side_count += 1
            next
          end
          if sorted[sort_by] - 1 == last_value
            last_value = sorted[sort_by]
            next
          end
          last_value = sorted[sort_by]

          side_count += 1
        end
      end
      side_count
    end

    def self.walk(map, x, y, tracking)
      key = "#{x}:#{y}"
      type = map[key][:type]

      map[key][:visited] = true
      tracking[0] += 1

      dirs = [[0, 1], [1, 0], [0, -1], [-1, 0]]
      dirs.each_with_index do |dir, idx|
        next_key = "#{x + dir[0]}:#{y + dir[1]}"
        next_type = map[next_key][:type] unless map[next_key].nil?

        if next_type != type
          tracking[1] += 1
          tracking[2] << [x, y, idx]
          next
        end
        next if map[next_key].nil? || map[next_key][:visited]

        tracking = walk(map, x + dir[0], y + dir[1], tracking)
      end

      tracking
    end
  end
end
