require 'spec_helper'

describe CodeDrivenDevelopment::CodeDrivenDevelopment do
  Dir["spec/samples/*.yaml"].each do |input_file_name|
    tests = YAML.load(File.read(input_file_name))
    tests.each do |test|
      test_name = test['title']
      input = test['input']
      output = test['output']
      generated_output = CodeDrivenDevelopment::CodeDrivenDevelopment.new(input).test_code

      it "handles #{test_name}" do
        expect(generated_output.strip).to eq output.strip
      end
    end
  end
end
