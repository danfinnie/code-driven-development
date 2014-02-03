module CodeDrivenDevelopment
  module TestComponent
    class Let
      def initialize(name, value)
        @name, @value = name, value
      end

      def indented_output(io)
        io << "let(:#@name) { #@value }"
      end
    end
  end
end
