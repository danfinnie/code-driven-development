module CodeDrivenDevelopment
  class IndentedOutput
    def initialize
      @nesting = 0
      @output = ""
    end

    def <<(str)
      @output << current_indentation << str << "\n"
    end

    def indented
      @nesting += 1
      yield
      @nesting -= 1
    end

    private

    def current_indentation
      "\t" * @nesting
    end
  end
end
