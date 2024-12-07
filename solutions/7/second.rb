# frozen_string_literal: true

module Day7
  module Part2
    def self.run(path, _)
      tests = []
      ops_lookup = {}
      FileReader.for_each_line(path) do |line|
        test_val, inputs = line.split(':')
        tests << {
          value: test_val.to_i,
          inputs: inputs.split.map(&:to_i)
        }
      end

      valids = []
      tests.each do |test|
        ops_lookup[test[:inputs].length - 1] = operations(test[:inputs].length - 1) if ops_lookup[test[:inputs].length - 1].nil?
        ops_lookup[test[:inputs].length - 1].each do |ops|
          res = calculate(test[:inputs], ops)
          if res == test[:value]
            valids << res
            break
          end
        end
      end
      valids.sum
    end

    def self.calculate(inputs, ops)
      res = 0
      inputs.each_with_index do |val, idx|
        if idx.zero?
          res = val
          next
        end
        res =
          if ops[idx - 1] == '||'
            "#{res}#{val}".to_i
          else
            eval("#{res} #{ops[idx - 1]} #{val}")
          end
      end
      res
    end

    def self.operations(n)
      ['+', '*', '||'].repeated_permutation(n).to_a
    end
  end
end
