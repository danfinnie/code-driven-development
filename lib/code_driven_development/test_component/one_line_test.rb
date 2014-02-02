module CodeDrivenDevelopment
  module TestComponent
    class OneLineTest
      def initialize(body = "")
        @body = body
      end

      attr_accessor :body

      def indented_output(io)
        io << "it { #@body }"
      end
    end
  end
end
