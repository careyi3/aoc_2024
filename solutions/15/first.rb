# frozen_string_literal: true

module Day15
  module Part1
    def self.run(path, _)
      map = {}
      is_map = true
      robot = []
      dirs = [[-1, 0], [0, -1], [1, 0], [0, 1]]
      moves = []
      x_max = 0
      y_max = 0
      FileReader.for_each_line_with_index(path) do |line, y|
        if line == ''
          is_map = false
          next
        end
        if is_map
          x_max = line.length - 1
          y_max = y
          line.chars.each_with_index do |char, x|
            map["#{x}:#{y}"] = char
            robot = [x, y] if char == '@'
          end
        else
          line.chars.each do |char|
            moves << 0 if char == '<'
            moves << 1 if char == '^'
            moves << 2 if char == '>'
            moves << 3 if char == 'v'
          end
        end
      end

      moves.each do |dir|
        cur_x, cur_y = robot
        next_x = dirs[dir][0] + cur_x
        next_y = dirs[dir][1] + cur_y

        key = "#{next_x}:#{next_y}"
        next_char = map[key]
        next if next_char == '#'

        if next_char == '.'
          map[key] = '@'
          map["#{cur_x}:#{cur_y}"] = '.'
          robot = [next_x, next_y]
        else
          inner_next_x = next_x
          inner_next_y = next_y
          loop do
            inner_next_x = dirs[dir][0] + inner_next_x
            inner_next_y = dirs[dir][1] + inner_next_y

            inner_key = "#{inner_next_x}:#{inner_next_y}"
            inner_next_char = map[inner_key]
            break if inner_next_char == '#'

            next unless inner_next_char == '.'

            map[key] = '@'
            map["#{cur_x}:#{cur_y}"] = '.'
            robot = [next_x, next_y]

            map["#{inner_next_x}:#{inner_next_y}"] = 'O'
            break
          end
        end

        # Visualisation.print_map(map, x_dim: x_max + 1, y_dim: y_max + 1, centre_x: x_max / 2, centre_y: y_max / 2, colour_char: '@', colour: :green, sleep: 0.01)
      end

      sum = 0
      map.each do |key, val|
        next unless val == 'O'

        x, y = key.split(':').map(&:to_i)
        sum += ((100 * y) + x)
      end
      sum
    end
  end
end
