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

      indexes = {}
      map.each_with_index do |val, idx|
        next if val == '.'

        if indexes[val].nil?
          indexes[val] = [idx]
        else
          indexes[val] << idx
        end
      end

      (block_id - 1).downto(0) do |id|
        instances = indexes[id]
        instances.each do |idx|
          map[idx] = '.'
        end

        count_blank = 0
        map.each_with_index do |val, idx|
          if val == '.'
            count_blank += 1
          else
            count_blank = 0
          end

          if idx == instances.first
            instances.each do |i|
              map[i] = id
            end
            break
          end

          next unless count_blank == instances.length

          instances.length.times do |i|
            map[idx - i] = id
          end
          break
        end
      end

      checksum = 0
      map.each_with_index do |id, idx|
        next if id == '.'

        checksum += (id * idx)
      end
      checksum
    end
  end
end
