# frozen_string_literal: true

module Day14
  module Part2
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

      grid = []
      7_138.times do |i|
        grid = Array.new(y_max) { Array.new(x_max) { '.' } }
        robots.each do |_, robot|
          new_x = ((robot[:x] + robot[:vx]) % x_max)
          new_y = ((robot[:y] + robot[:vy]) % y_max)
          robot[:x] = new_x
          robot[:y] = new_y
          grid[new_x][new_y] = '#'
        end

        Visualisation.print_grid(grid, centre_x: x_mid, centre_y: y_mid, x_dim: x_max, y_dim: y_max, sleep: 0, spacer: ' ') if i + 1 == 7_138
      end
      7_138
    end
  end
end
