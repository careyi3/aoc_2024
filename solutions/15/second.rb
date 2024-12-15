# frozen_string_literal: true

module Day15
  module Part2
    def self.run(path, _)
      map = {}
      is_map = true
      state = []
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
          y_max = y
          chars = []
          line.chars.each do |char|
            if char == '@'
              chars << '@'
              chars << '.'
            elsif char == 'O'
              chars << '['
              chars << ']'
            else
              chars << char
              chars << char
            end
          end
          x_max = chars.length - 1
          chars.each_with_index do |char, x|
            map["#{x}:#{y}"] = char
            state = [x, y, false] if char == '@'
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
        x, y, = state

        state = move(state, map, dirs, dir, [[x, y]], [])
        Visualisation.print_map(map, x_dim: x_max + 1, y_dim: x_max + 1, centre_x: x_max / 2, centre_y: x_max / 2, colour_char: '@', colour: :green, sleep: 1)
      end

      sum = 0
      map.each do |key, val|
        next unless val == '['

        x, y = key.split(':').map(&:to_i)
        sum += ((100 * y) + x)
      end
      sum
    end

    def self.move(state, map, dirs, dir, points, chars)
      x, y = points.pop
      key = "#{x}:#{y}"
      char = map[key]
      return state if char == '#'

      map[key] = '.'

      if char == '.'
        unless points.empty?
          a, b = points.pop
          state = move(state, map, dirs, dir, [[a, b]], chars)
        end
        map[key] = chars.pop
        state = [x, y] if map[key] == '@'
        return state
      end

      chars.push(char)

      if [0, 2].include?(dir)
        state = move(state, map, dirs, dir, [[dirs[dir][0] + x, dirs[dir][1] + y]], chars)
      else
        state =
          if char == '['
            move(state, map, dirs, dir, [[x + 1, y], [dirs[dir][0] + x, dirs[dir][1] + y]], chars)
          elsif char == ']'
            move(state, map, dirs, dir, [[x - 1, y], [dirs[dir][0] + x, dirs[dir][1] + y]], chars)
          else
            move(state, map, dirs, dir, [[dirs[dir][0] + x, dirs[dir][1] + y]], chars)
          end
      end

      map[key] = chars.pop unless chars.empty?
      state = [x, y] if map[key] == '@'

      state
    end
  end
end
