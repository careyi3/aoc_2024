# frozen_string_literal: true

module Day23
  module Part1
    def self.run(path, _)
      connections = {}
      points = {}
      FileReader.for_each_line(path) do |line|
        a, b = line.split('-')
        points[a] = true
        points[b] = true
        if connections[a].nil?
          connections[a] = [b]
        else
          connections[a] << b
        end
        if connections[b].nil?
          connections[b] = [a]
        else
          connections[b] << a
        end
      end
      valid = []
      points.keys.combination(3).each do |set|
        next unless ([set[1], set[2]] - connections[set[0]]).empty? &&
                    ([set[0], set[2]] - connections[set[1]]).empty? &&
                    ([set[0], set[1]] - connections[set[2]]).empty?

        valid << set
      end
      count = 0
      valid.each do |set|
        count += 1 if set.map { |x| x.chars[0] }.include?('t')
      end
      count
    end
  end
end
