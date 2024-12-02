# frozen_string_literal: true

module Day2
  module Part2
    def self.run(path, _)
      reports = []
      FileReader.for_each_line(path) do |line|
        reports << line.split.map(&:to_i)
      end
      safe_count = 0
      reports.each do |levels|
        new_reports = []
        levels.each_with_index do |_, idx|
          new_reports << levels.reject.with_index { |_, i| i == idx }
        end

        new_reports.each do |new_levels|
          if safe_levels(new_levels)
            safe_count += 1
            break
          end
        end
      end
      safe_count
    end

    def self.safe_levels(levels)
      return false if levels.uniq != levels
      return false unless levels.sort == levels || levels.sort.reverse == levels

      safe = true
      levels.sort.each_cons(2).to_a.each do |f, s|
        if s - f > 3
          safe = false
          break
        end
      end
      safe
    end
  end
end
