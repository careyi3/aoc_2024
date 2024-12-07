# frozen_string_literal: true

module Day7
  module Part2
    def self.run(path, _)
      tests = []
      FileReader.for_each_line(path) do |line|
        test_val, inputs = line.split(':')
        tests << {
          value: test_val.to_i,
          inputs: inputs.split.map(&:to_i)
        }
      end

      valids = []
      tests.each do |test|
        valids << test[:value] if test[:value] == calc(test[:value], test[:inputs], -1)
      end
      valids.sum
    end

    def self.calc(test_val, inputs, value)
      return value if inputs.length.zero?

      value = inputs.shift if value == -1
      new_val = inputs.shift
      res1 = calc(test_val, inputs.clone, value + new_val)
      res2 = calc(test_val, inputs.clone, value * new_val)
      res3 = calc(test_val, inputs.clone, "#{value}#{new_val}".to_i)

      return res1 if res1 == test_val
      return res2 if res2 == test_val
      return res3 if res3 == test_val

      0
    end
  end
end
