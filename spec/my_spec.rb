require 'spec_helper'

describe CodeDrivenDevelopment::CodeDrivenDevelopment do
  before do
    implementation = <<-EOT
      class Lolcat < ActiveRecord::Base
        validate :cuteness, presence: true

        def i_call_things
          CentralBureaucracy.file_report
        end
      end
    EOT

    @test = CodeDrivenDevelopment::CodeDrivenDevelopment.new(implementation).test_code
  end

  it "puts the model name in the describe description" do
    expect(@test).to match /^describe Lolcat do/
  end

  it "includes shoulda-matchers for simple validations" do
    expect(@test).to match /^\tit.*should.*validate_presence_of.*:cuteness/
  end

  it "stubs out method calls" do
    expect(@test).to have_consecutive_lines_matching [
      /^\tdescribe.*#i_call_things/,
      /^\t\tbefore/,
      /^\t\t\tallow.CentralBureaucracy..to.*receive.*:file_report/,
      /^\t\t\tdescribed_class.new.i_call_things/,
      /^\t\tit.*calls Central.*do/,
      /^\t\t\texpect.CentralBureaucracy..to.*have_received.*:file_report/
    ]
  end
end
