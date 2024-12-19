# frozen_string_literal: true

module Day19
  module Part1
    def self.run(path, _)
      pattern = true
      stripes = []
      towels = []
      FileReader.for_each_line(path) do |line|
        next if line == ''

        if pattern
          stripes = line.gsub(/\s+/, '').split(',')
          pattern = false
        else
          towels << line
        end
      end
      valid = 0
      towels.each do |towel|
        valid += 1 if find(stripes, towel)
      end
      valid
    end

    def self.find(stripes, pattern)
      return true if pattern == ''

      to_check = starts_with(stripes, pattern)
      return false if to_check.empty?

      to_check.each do |p|
        n = p.length
        return true if find(stripes, pattern[n..])
      end
      false
    end

    def self.starts_with(stripes, pattern)
      patterns = []
      stripes.each do |stripe|
        patterns << stripe if pattern.start_with?(stripe)
      end
      patterns
    end
  end
end
