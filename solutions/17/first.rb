# frozen_string_literal: true

module Day17
  module Part1
    def self.run(path, _)
      commands = {
        0 => lambda do |ip, operand, registers|
          registers['A'] = (registers['A'] / 2.pow(operand_value(operand, registers, :c))).truncate
          ip += 1
          return ip
        end,
        1 => lambda do |ip, operand, registers|
          registers['B'] = (registers['B'] ^ operand_value(operand, registers, :l))
          ip += 1
          return ip
        end,
        2 => lambda do |ip, operand, registers|
          registers['B'] = (operand_value(operand, registers, :c) % 8)
          ip += 1
          return ip
        end,
        3 => lambda do |ip, operand, registers|
          if registers['A'].zero?
            ip += 1
            return ip
          end

          ip = operand_value(operand, registers, :l) / 2
          return ip
        end,
        4 => lambda do |ip, _operand, registers|
          registers['B'] = (registers['B'] ^ registers['C'])
          ip += 1
          return ip
        end,
        5 => lambda do |ip, operand, registers|
          registers['O'] << (operand_value(operand, registers, :c) % 8)
          ip += 1
          return ip
        end,
        6 => lambda do |ip, operand, registers|
          registers['B'] = (registers['A'] / 2.pow(operand_value(operand, registers, :c))).truncate
          ip += 1
          return ip
        end,
        7 => lambda do |ip, operand, registers|
          registers['C'] = (registers['A'] / 2.pow(operand_value(operand, registers, :c))).truncate
          ip += 1
          return ip
        end
      }
      registers = { 'O' => [] }
      instructions = []

      FileReader.for_each_line(path) do |line|
        next if line == ''

        result = line.gsub(':', '').split
        if result[0] == 'Register'
          registers[result[1]] = result[2].to_i
        else
          instructions = result[1].split(',').map(&:to_i).each_slice(2).to_a
        end
      end

      ip = 0
      loop do
        break if instructions[ip].nil?

        opcode, operand = instructions[ip]
        ip = commands[opcode].call(ip, operand, registers)
      end
      registers['O'].join(',')
    end

    def self.operand_value(operand, registers, type)
      return operand if type == :l

      return operand if operand >= 0 && operand <= 3

      return registers['A'] if operand == 4
      return registers['B'] if operand == 5
      return registers['C'] if operand == 6

      nil
    end
  end
end
