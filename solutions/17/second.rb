# frozen_string_literal: true

module Day17
  module Part2
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
      instructions = []
      FileReader.for_each_line(path) do |line|
        next if line == ''

        result = line.gsub(':', '').split
        instructions = result[1].split(',').map(&:to_i).each_slice(2).to_a if result[0] == 'Program'
      end

      program = instructions.flatten
      as = []
      8.times do |a|
        find(commands, instructions, program, as, a, 0)
      end
      as.min
    end

    def self.find(commands, instructions, program, as, a, depth)
      result = calculate(commands, instructions, a)
      return if result != program.slice(program.length - result.length, result.length)

      if depth == program.length - 1
        as << a
      else
        8.times do |b|
          find(commands, instructions, program, as, (a * 8) + b, depth + 1)
        end
      end
    end

    def self.calculate(commands, instructions, a)
      registers = {
        'A' => a,
        'B' => 0,
        'C' => 0,
        'O' => []
      }
      ip = 0
      loop do
        break if instructions[ip].nil?

        opcode, operand = instructions[ip]
        ip = commands[opcode].call(ip, operand, registers)
      end
      registers['O']
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
