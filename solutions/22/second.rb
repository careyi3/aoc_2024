# frozen_string_literal: true

module Day22
  module Part2
    def self.run(path, _)
      nums = []
      FileReader.for_each_line(path) do |line|
        nums << line.to_i
      end

      changes = {}
      nums.each_with_index do |num, i|
        last_num = num
        changes[i] = {}
        seq = []
        2000.times do
          d1 = last_num % 10
          last_num = calculate(last_num)
          d2 = last_num % 10
          if seq.length < 4
            seq << (d2 - d1)
            next
          end
          seq.shift
          seq << (d2 - d1)

          if changes[i][seq.join(':')].nil?
            changes[i][seq.join(':')] = [d2]
          else
            changes[i][seq.join(':')] << d2
          end
        end
      end

      sequences = {}
      changes.each do |_, seqs|
        seqs.each do |seq, values|
          if sequences[seq].nil?
            sequences[seq] = values.first
          else
            sequences[seq] += values.first
          end
        end
      end
      sequences.values.max
    end

    def self.calculate(secret_num)
      x = secret_num * 64
      secret_num = secret_num ^ x
      secret_num = secret_num % 16_777_216

      y = (secret_num / 32).floor
      secret_num = secret_num ^ y
      secret_num = secret_num % 16_777_216

      z = secret_num * 2048
      secret_num = secret_num ^ z
      secret_num % 16_777_216
    end
  end
end
