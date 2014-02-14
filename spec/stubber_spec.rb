require 'spec_helper'

describe CodeDrivenDevelopment::Stubber::Stubber do
  let(:sexp) { RubyParser.new.parse(code) }
  let(:stubber) { CodeDrivenDevelopment::Stubber::Stubber.new(sexp) }

  context "invoking a constant's method" do
    let(:code) { "Constant.zulu" }

    it "stubs like a boss" do
      expect(stubber.befores).to eq ["allow(Constant).to receive :zulu"]
    end

    it "has a legit human name" do
      expect(stubber.human_name).to eq "Constant.zulu"
    end

    it "can create a test body" do
      expect(stubber.body).to eq [
        "expect(Constant).to have_received :zulu"
      ]
    end
  end

  context "invoking an instance method of self" do
    let(:code) { "zulu" }

    it "stubs like a boss" do
      expect(stubber.befores).to eq ["allow(obj).to receive :zulu"]
    end

    it "has a legit human name" do
      expect(stubber.human_name).to eq "#zulu"
    end

    it "can create a test body" do
      expect(stubber.body).to eq [
        "expect(obj).to have_received :zulu"
      ]
    end
  end
end
