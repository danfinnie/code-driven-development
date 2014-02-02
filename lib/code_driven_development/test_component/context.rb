module CodeDrivenDevelopment
  module TestComponent
    class Context
      def initialize(description = nil, befores = [], tests = [])
        @description, @befores, @tests = description, befores, tests
      end

      attr_reader :tests, :befores
      attr_accessor :description

      def << child
        @tests << child
      end

      def indented_output io
        io << "describe #@description do"
        io.indented do
          if befores.any?
            io << "before do"
            io.indented do
              befores.each { |before| io << before }
            end
            io << "end"
          end
          tests.each { |test| test.indented_output(io) }
        end
        io << "end"
      end
    end
  end
end
