# frozen_string_literal: true

module Day4
  module Part1
    def self.run(path, _)
      word_search = {}
      xs = {}
      FileReader.for_each_line_with_index(path) do |line, y|
        line.chars.each_with_index do |char, x|
          coord = "#{x}:#{y}"
          word_search[coord] = char
          xs[coord] = nil if char == 'X'
        end
      end

      count = 0
      xs.each do |coords, _|
        words = []
        x, y = coords.split(':').map(&:to_i)
        8.times { words << ['X'] }
        3.times do |i|
          idx = i + 1
          words[0] << word_search["#{x + idx}:#{y}"]
          words[1] << word_search["#{x}:#{y + idx}"]
          words[2] << word_search["#{x - idx}:#{y}"]
          words[3] << word_search["#{x}:#{y - idx}"]
          words[4] << word_search["#{x + idx}:#{y + idx}"]
          words[5] << word_search["#{x - idx}:#{y - idx}"]
          words[6] << word_search["#{x + idx}:#{y - idx}"]
          words[7] << word_search["#{x - idx}:#{y + idx}"]
        end
        count += words.map(&:join).select { |w| w == 'XMAS' }.count
      end
      count
    end
  end
end
