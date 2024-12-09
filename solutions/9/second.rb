# frozen_string_literal: true

module Day9
  module Part2
    def self.run(path, _)
      line = FileReader.read_file(path)
      block_id = 0
      map = []
      line.chars.map(&:to_i).each_with_index do |block, idx|
        block.times do
          map <<
            if (idx % 2).zero?
              block_id
            else
              '.'
            end
        end

        block_id += 1 if (idx % 2).zero?
      end

      map.each_with_index do |val, idx|
        next unless val == '.'

        new_block = map.pop
        new_block = map.pop while new_block == '.'
        map[idx] = new_block
      end

      checksum = 0
      map.each_with_index do |block_id, idx|
        checksum += (block_id * idx)
      end
      checksum
    end
  end
end
