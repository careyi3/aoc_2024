# frozen_string_literal: true

module Day19
  module Part2
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
      combos = 0
      towels.each do |towel|
        combos += find(stripes, towel, {})
      end
      combos
    end

    def self.find(stripes, pattern, cache)
      return cache[pattern] unless cache[pattern].nil?
      return 1 if pattern == ''

      to_check = starts_with(stripes, pattern)
      return 0 if to_check.empty?

      results = []
      to_check.each do |p|
        n = p.length
        res = find(stripes, pattern[n..], cache)
        results << res
      end
      cache[pattern] = results.sum
      results.sum
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
