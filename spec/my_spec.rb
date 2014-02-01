require 'spec_helper'

describe Tester::Tester do
  before do
    implementation = <<-EOT
      class Lolcat < ActiveRecord::Base
        validate :cuteness, presence: true
      end
    EOT

    @test = Tester::Tester.new(implementation).test_code
  end

  it "puts the model name in the describe description" do
    expect(@test).to match /describe Lolcat/
  end

  it "includes shoulda-matchers for simple validations" do
    expect(@test).to match /it.*should.*validate_presence_of.*:cuteness/
  end
end
