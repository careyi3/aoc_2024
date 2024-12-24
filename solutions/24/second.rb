# frozen_string_literal: true

module Day24
  module Part2
    OPS = {
      'AND' => ->(a, b) { a & b },
      'OR' => ->(a, b) { a | b },
      'XOR' => ->(a, b) { a ^ b }
    }.freeze

    def self.run(path, _)
      connections = {}
      wires = true
      zs = []
      xs = []
      ys = []
      FileReader.for_each_line(path) do |line|
        if line == ''
          wires = false
          next
        end
        if wires
          id, val = line.gsub(':', '').split
          connections[id] = ->(_ops) { val.to_i }
          xs << id if id[0] == 'x'
          ys << id if id[0] == 'y'
        else
          a, op, b, _, c = line.split
          connections[c] = lambda { |ops|
            ops << "#{c}-#{op}"
            result = OPS[op].call(connections[a].call(ops), connections[b].call(ops))
            connections[c] = ->(_ops) { result }
            result
          }
          zs << c if c[0] == 'z'
        end
      end
      bin = ''
      ops = {}
      zs.sort.each_with_index do |z, idx|
        o = []
        bin += connections[z].call(o).to_s
        ops[idx] = o
      end
      puts bin.chars.reverse.join

      ops.delete(0)
      ops.delete(1)
      ops.delete(45)

      correct = {
        'XOR' => 2,
        'AND' => 2,
        'OR' => 1
      }

      # I manually looked at the outputs of this and determined which things to test, I then modified my input file until this ops hash was empty.
      ops.each do |key, value|
        res = value.map { |x| x.split('-')[1] }.tally
        ops.delete(key) if res == correct
      end

      binding.pry if ops.count != 0

      %w[fph z15 gds z21 cqk z34 wrk jrs].sort.join(',')
    end
  end
end
