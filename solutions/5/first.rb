# frozen_string_literal: true

module Day5
  module Part1
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

      valid = []
      updates.each do |update|
        temp = update.clone
        is_valid = true
        update.reverse.each do |num|
          next if rules[num].nil?

          temp.pop
          must_be_before = rules[num]
          if must_be_before != (must_be_before - temp)
            is_valid = false
            break
          end
        end
        valid << update if is_valid
      end

      valid.map { |x| x[x.count / 2] }.sum
    end
  end
end
