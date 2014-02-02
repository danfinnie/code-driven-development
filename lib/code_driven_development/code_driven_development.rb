module CodeDrivenDevelopment
  class CodeDrivenDevelopment
    def initialize(implementation)
      @implementation = implementation
    end

    def test_code
      <<-"EOT"
        describe #{described_class} do
          #{shoulda_matchers.join("\n")}
        end
      EOT
    end

    private

    attr_reader :implementation

    def described_class
      implementation[/class\s*(\S+)/, 1]
    end

    def shoulda_matchers
      validations.map do |validation|
        "it { should validate_#{validation.type}_of :#{validation.field} }"
      end
    end

    def validations
      implementation.each_line.map do |line|
        Validation.from_line(line)
      end.compact
    end
  end
end
