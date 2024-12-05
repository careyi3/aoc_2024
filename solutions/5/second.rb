# frozen_string_literal: true

module Day5
  module Part2
    def self.run(path, _)
      rule = true
      rules = {}
      updates = []
      FileReader.for_each_line(path) do |line|
        if line == ''
          rule = false
          next
        end

        if rule
          f, s = line.split('|').map(&:to_i)
          rules[f] =
            if rules[f].nil?
              [s]
            else
              rules[f] + [s]
            end
        else
          updates << line.split(',').map(&:to_i)
        end
      end

      sorted_invalids = []
      updates.each do |update|
        sorted = update.sort { |a, b| sort_by_rules(a, b, rules) }
        sorted_invalids << sorted if sorted.reverse != update
      end

      sorted_invalids.map { |x| x[x.count / 2] }.sum
    end

    def self.sort_by_rules(a, b, rules)
      if rules[a].nil?
        0
      elsif rules[a].include?(b)
        1
      else
        -1
      end
    end
  end
end
