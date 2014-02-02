module CodeDrivenDevelopment
  module TestComponent
    class BlankSlate
      def initialize
        @children = []
      end

      def indented_output(io = IndentedOutput.new)
        @children.map do |child|
          child.indented_output(io)
        end.join
      end

      def << child
        @children << child
      end
    end
  end
end
