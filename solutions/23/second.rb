# frozen_string_literal: true

module Day23
  module Part1
    def self.run(path, _)
      connections = {}
      computers = {}
      FileReader.for_each_line(path) do |line|
        a, b = line.split('-')
        computers[a] = 0
        computers[b] = 0
        if connections[a].nil?
          connections[a] = [b]
        else
          connections[a] << b
        end
        if connections[b].nil?
          connections[b] = [a]
        else
          connections[b] << a
        end
      end

      computers.keys.each_with_index do |key, idx|
        computers[key] = idx
      end

      sets = []
      i = 0
      connections.each do |key, val|
        sets[i] = [key]
        val.each do |v|
          sets[i] << v
        end
        i += 1
      end

      binary_sets = []
      sets.each do |set|
        binary_sets << generate_binary(computers, set)
      end

      ands = []
      binary_sets.combination(2).each do |combo|
        a, b = combo

        ands << aand(a, b, computers.length)
      end

      ans = ands.tally.sort_by { |_, value| value }.reverse[1][0]
      result = []
      ans.chars.each_with_index do |char, idx|
        result << computers.keys[idx] if char == '1'
      end
      result.sort.join(',')
    end

    def self.aand(a, b, bit_length)
      eval("('%0#{bit_length}b' % (0b#{a}&0b#{b}))")
    end

    def self.generate_binary(computers, set)
      bits = Array.new(computers.length) { 0 }
      set.each do |computer|
        bits[computers[computer]] = 1
      end
      bits.join
    end
  end
end
