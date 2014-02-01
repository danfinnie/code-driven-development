module Tester
  class Validation
    attr_reader :type, :field

    def self.from_line(line)
      new(line) rescue nil
    end

    def initialize(line)
      @field, @type = line.match(/validate (:\w+), (\w+)/)[1..2]
    end
  end
end
