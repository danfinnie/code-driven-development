module CodeDrivenDevelopment
  module TestComponent
    class Context
      def initialize(description = nil, tests = [])
        @description, @tests = description, tests
      end

      attr_reader :tests
      attr_accessor :description

      def << child
        @tests << child
      end

      def indented_output io
        io << "describe #@description do"
        io.indented do
          tests.each { |test| test.indented_output(io) }
        end
        io << "end"
      end
    end
  end
end
