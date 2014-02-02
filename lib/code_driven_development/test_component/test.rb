module CodeDrivenDevelopment
  module TestComponent
    class Test
      def initialize(description = "", body = "")
        @description, @body = description, body
      end

      attr_accessor :description, :body

      def indented_output io
        io << "it \"#@description\" do"
        io.indented do
          body.each { |line| io << line }
        end
        io << "end"
      end
    end
  end
end
