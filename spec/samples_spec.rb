require 'spec_helper'

describe CodeDrivenDevelopment::CodeDrivenDevelopment do
  Dir["spec/samples/*_input.rb"].each do |input_file_name|
    test_name = input_file_name[/([^\/]+)_input\.rb/, 1]
    output_file_name = input_file_name.sub("input.rb", "output.rb")
    input = File.read(input_file_name)
    generated_output = CodeDrivenDevelopment::CodeDrivenDevelopment.new(input).test_code
    output = File.read(output_file_name)

    it "handles #{test_name}" do
      expect(generated_output.strip).to eq output.strip
    end
  end
end
