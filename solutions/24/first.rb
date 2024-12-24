# frozen_string_literal: true

module Day24
  module Part1
    OPS = {
      'AND' => ->(a, b) { a & b },
      'OR' => ->(a, b) { a | b },
      'XOR' => ->(a, b) { a ^ b }
    }.freeze

    def self.run(path, _)
      connections = {}
      wires = true
      zs = []
      FileReader.for_each_line(path) do |line|
        if line == ''
          wires = false
          next
        end
        if wires
          id, val = line.gsub(':', '').split
          connections[id] = -> { val.to_i }
        else
          a, op, b, _, c = line.split
          connections[c] = -> { OPS[op].call(connections[a].call, connections[b].call) }
          zs << c if c[0] == 'z'
        end
      end
      bin = ''
      zs.sort.reverse.each do |z|
        bin += connections[z].call.to_s
      end
      bin.to_i(2)
    end
  end
end
