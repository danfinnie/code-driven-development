module CodeDrivenDevelopment
  module TestComponent
    class Context
      def initialize(description = nil, befores = [], tests = [], lets = [])
        @description, @befores, @tests, @lets = description, befores, tests, lets
      end

      attr_reader :tests, :befores, :lets
      attr_accessor :description

      def << child
        @tests << child
      end

      def indented_output io
        io << ""
        io << "describe #@description do"
        io.indented do
          lets.each do |let|
            let.indented_output(io)
          end
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
