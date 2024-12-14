# frozen_string_literal: true

module Day14
  module Part1
    def self.run(path, input)
      x_max = input == 'sample' ? 11 : 101
      y_max = input == 'sample' ? 7 : 103
      x_mid = x_max / 2
      y_mid = y_max / 2

      robots = {}
      robot_id = 0
      FileReader.for_each_line(path) do |line|
        x, y, vx, vy = line.scan(/-?\d{1,3}/).map(&:to_i)
        robots[robot_id] = { x:, y:, vx:, vy: }
        robot_id += 1
      end

      100.times do
        robots.each do |_, robot|
          new_x = ((robot[:x] + robot[:vx]) % x_max)
          new_y = ((robot[:y] + robot[:vy]) % y_max)
          robot[:x] = new_x
          robot[:y] = new_y
        end
      end

      map = {}
      robots.each do |id, robot|
        map["#{robot[:x]}:#{robot[:y]}"] =
          if map["#{robot[:x]}:#{robot[:y]}"].nil?
            [id]
          else
            map["#{robot[:x]}:#{robot[:y]}"] + [id]
          end
      end

      quadrents = [0, 0, 0, 0]
      map.each do |coords, robot_ids|
        x, y = coords.split(':').map(&:to_i)
        quadrents[0] += robot_ids.count if x < x_mid && y < y_mid
        quadrents[1] += robot_ids.count if x < x_mid && y > y_mid
        quadrents[2] += robot_ids.count if x > x_mid && y < y_mid
        quadrents[3] += robot_ids.count if x > x_mid && y > y_mid
      end
      quadrents.inject(:*)
    end
  end
end
