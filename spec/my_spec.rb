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
    expect(@test).to match /describe Lolcat do/
  end

  it "includes shoulda-matchers for simple validations" do
    expect(@test).to match /it.*should.*validate_presence_of.*:cuteness/
  end
end
