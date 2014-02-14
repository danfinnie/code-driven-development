module CodeDrivenDevelopment
  module TestComponent
    class Context
      def initialize(description = nil, befores = [], tests = [], lets = [], subject = nil)
        @description, @befores, @tests, @lets, @subject, @doubles = description, befores, tests, lets, subject, []
      end

      attr_reader :tests, :befores, :lets, :doubles
      attr_accessor :description, :subject

      def << child
        @tests << child
      end

      def indented_output io
        io << "describe #@description do"
        io.indented do
          lets.each do |let|
            let.indented_output(io)
          end
          doubles.each do |double|
            double.indented_output(io)
          end
          if subject
            io << "subject { #{subject} }"
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
