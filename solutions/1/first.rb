# frozen_string_literal: true

module Day1
  module Part1
    def self.run(path, _)
      FileReader.for_each_line(path) do |line|
        puts line
      end
    end
  end
end
