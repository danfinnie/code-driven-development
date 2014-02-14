module CodeDrivenDevelopment
  module TestComponent
    class Double
      def initialize(name)
        @name = name
      end

      def indented_output(io)
        io << "let(:#@name) { double(:#@name) }"
      end
    end
  end
end
