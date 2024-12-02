# frozen_string_literal: true

module Day2
  module Part1
    def self.run(path, _)
      reports = []
      FileReader.for_each_line(path) do |line|
        reports << line.split.map(&:to_i)
      end
      safe_count = 0
      reports.each do |levels|
        next if levels.uniq != levels
        next unless levels.sort == levels || levels.sort.reverse == levels

        safe = true
        levels.sort.each_cons(2).to_a.each do |f, s|
          if s - f > 3
            safe = false
            break
          end
        end

        safe_count += 1 if safe
      end
      safe_count
    end
  end
end
