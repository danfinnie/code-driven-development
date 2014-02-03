require 'spec_helper'

describe CodeDrivenDevelopment::CodeDrivenDevelopment do
  before do
    implementation = <<-EOT
      class Lolcat < ActiveRecord::Base
        validate :cuteness, presence: true

        def i_call_things
          CentralBureaucracy.file_report
        end

        def i_call_instance_methods
          meth
        end

        def weigh_options
          should_i_stay || should_i_go
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

  it "stubs out method calls to constants" do
    expect(@test).to have_consecutive_lines_matching [
      /^\tdescribe.*"#i_call_things"/,
      /^\t\tbefore/,
      /^\t\t\tallow.CentralBureaucracy..to.*receive.*:file_report/,
      /^\t\t\tobj.i_call_things/,
      /^\t\tit.*calls Central.*do/,
      /^\t\t\texpect.CentralBureaucracy..to.*have_received.*:file_report/
    ]
  end

  it "stubs out instance method calls" do
    expect(@test).to have_consecutive_lines_matching [
      /^\tdescribe.*"#i_call_instance_methods"/,
      /^\t\tlet.:obj.*described_class.new/,
      /^\t\tbefore/,
      /^\t\t\tallow.obj..to.*receive.*:meth/,
      /^\t\t\tobj.i_call_instance_methods/,
      /^\t\tit.*calls #meth.*do/,
      /^\t\t\texpect.obj..to.*have_received.*:meth/
    ]
  end

  it "handles ORs with aplomb" do
    expect(@test).to have_consecutive_lines_matching [
      /^\tdescribe.*"#weigh_options"/,
      /^\t\tlet.:obj.*described_class.new/,
      /^\t\tbefore/,
      /^\t\t\tallow.obj..to.*receive.*:should_i_stay/,
      /^\t\t\tallow.obj..to.*receive.*:should_i_go/,
      /^\t\tcontext.*when.*should_i_stay.*truthy/,
      /^\t\tbefore do/,
      /^\t\t\t
      /^\t\t\tobj.weigh_options/,
      /^\t\tit.*calls #meth.*do/,
      /^\t\t\texpect.obj..to.*have_received.*:meth/
    ]
  end
end
