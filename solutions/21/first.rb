# frozen_string_literal: true

module Day21
  module Part1
    NUM_PAD = {
      '0:3' => '9',
      '1:3' => '8',
      '2:3' => '7',
      '0:2' => '6',
      '1:2' => '5',
      '2:2' => '4',
      '0:1' => '3',
      '1:1' => '2',
      '2:1' => '1',
      '1:0' => '0',
      '0:0' => 'A',

      '9' => [0, 3],
      '8' => [1, 3],
      '7' => [2, 3],
      '6' => [0, 2],
      '5' => [1, 2],
      '4' => [2, 2],
      '3' => [0, 1],
      '2' => [1, 1],
      '1' => [2, 1],
      '0' => [1, 0],
      'A' => [0, 0]
    }.freeze

    NUM_PAD_DIRS = {
      0 => '<',
      1 => '^',
      2 => '>',
      3 => 'v'
    }.freeze

    D_PAD = {
      '0:1' => '>',
      '2:1' => '<',
      '1:1' => 'v',
      '1:0' => '^',
      '0:0' => 'A',

      '>' => [0, 1],
      '<' => [2, 1],
      'v' => [1, 1],
      '^' => [1, 0],
      'A' => [0, 0]
    }.freeze

    D_PAD_DIRS = {
      0 => '<',
      1 => 'v',
      2 => '>',
      3 => '^'
    }.freeze

    def self.run(path, _)
      inputs = []
      FileReader.for_each_line(path) do |line|
        inputs << "A#{line}"
      end

      sequences = {}
      inputs.each do |input|
        sequences[input] = []
        input.chars.each_cons(2) do |combination|
          seqs = []
          x1, y1 = NUM_PAD[combination[0]]
          x2, y2 = NUM_PAD[combination[1]]
          shortest_path = (x2 - x1).abs + (y2 - y1).abs
          walk_num_pad(NUM_PAD[combination[0]], NUM_PAD[combination[1]], '', seqs, shortest_path)
          sequences[input] << seqs.uniq
        end
      end

      sequences.each do |_, seqs|
        paths = []
        process_sequences(seqs, paths, '', 0)
        binding.pry
      end

      binding.pry
    end

    def self.process_sequences(seqs, paths, path, depth)
      seqs.each do |seq|
        if seq.instance_of?(String)
          if depth == 2
            paths << seq
            next
          end

          all = []
          "A#{seq}".chars.each_cons(2) do |combination|
            result = []
            x1, y1 = D_PAD[combination[0]]
            x2, y2 = D_PAD[combination[1]]
            shortest_path = (x2 - x1).abs + (y2 - y1).abs
            walk_d_pad(D_PAD[combination[0]], D_PAD[combination[1]], '', result, shortest_path)
            all << result.uniq
          end
          process_sequences(all, paths, path, depth + 1)
        else
          process_sequences(seq, paths, path, depth)
        end
      end
    end

    def self.walk_num_pad(start, finish, seq, seqs, shortest_path)
      return if seq.length > shortest_path

      if start == finish
        seqs << "#{seq}A"
        return
      end

      x1, y1 = start

      [[1, 0], [0, 1], [-1, 0], [0, -1]].each_with_index do |dir, i|
        next_x = dir[0] + x1
        next_y = dir[1] + y1
        next_start = [next_x, next_y]
        walk_num_pad(next_start, finish, seq + NUM_PAD_DIRS[i], seqs, shortest_path) unless NUM_PAD["#{next_x}:#{next_y}"].nil?
      end
    end

    def self.walk_d_pad(start, finish, seq, seqs, shortest_path)
      return if seq.length > shortest_path

      if start == finish
        seqs << "#{seq}A"
        return
      end

      x1, y1 = start

      [[1, 0], [0, 1], [-1, 0], [0, -1]].each_with_index do |dir, i|
        next_x = dir[0] + x1
        next_y = dir[1] + y1
        next_start = [next_x, next_y]
        walk_d_pad(next_start, finish, seq + D_PAD_DIRS[i], seqs, shortest_path) unless D_PAD["#{next_x}:#{next_y}"].nil?
      end
    end
  end
end
