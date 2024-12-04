# frozen_string_literal: true

module Day4
  module Part2
    def self.run(path, _)
      word_search = {}
      xs = {}
      FileReader.for_each_line_with_index(path) do |line, y|
        line.chars.each_with_index do |char, x|
          coord = [x, y]
          word_search[coord] = char
          xs[coord] = nil if char == 'A'
        end
      end

      count = 0
      xs.each do |coords, _|
        x, y = coords
        next unless %w[MAS SAM].include?("#{word_search[[x - 1, y + 1]]}A#{word_search[[x + 1, y - 1]]}")
        next unless %w[MAS SAM].include?("#{word_search[[x - 1, y - 1]]}A#{word_search[[x + 1, y + 1]]}")

        count += 1
      end
      count
    end
  end
end
