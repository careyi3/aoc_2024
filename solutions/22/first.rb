# frozen_string_literal: true

module Day22
  module Part1
    def self.run(path, _)
      nums = []
      FileReader.for_each_line(path) do |line|
        nums << line.to_i
      end

      new_nums = []
      nums.each do |num|
        next_num = num
        2000.times do
          next_num = calculate(next_num)
        end
        new_nums << next_num
      end
      new_nums.sum
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
