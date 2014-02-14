require 'spec_helper'

describe CodeDrivenDevelopment::Stubber::Stubber do
  let(:sexp) { RubyParser.new.parse(code) }
  let(:stubber) { CodeDrivenDevelopment::Stubber::Stubber.new(sexp) }

  context "invoking a constant's method" do
    let(:code) { "Constant.zulu" }

    it "stubs like a boss" do
      expect(stubber.befores).to eq ["allow(Constant).to receive(:zulu).and_return(zulu)"]
    end

    it "has a legit human name" do
      expect(stubber.human_name).to eq "Constant.zulu"
    end

    it "can create a test body" do
      expect(stubber.body).to eq [
        "expect(Constant).to have_received :zulu"
      ]
    end

    it "has some doubles" do
      expect(stubber.doubles).to match_array [:zulu]
    end
  end

  context "invoking an instance method of self" do
    let(:code) { "zulu" }

    it "stubs like a boss" do
      expect(stubber.befores).to eq ["allow(obj).to receive(:zulu).and_return(zulu)"]
    end

    it "has a legit human name" do
      expect(stubber.human_name).to eq "zulu"
    end

    it "can create a test body" do
      expect(stubber.body).to eq [
        "expect(obj).to have_received :zulu"
      ]
    end

    it "has some doubles" do
      expect(stubber.doubles).to match_array [:zulu]
    end
  end

  context "a double method call" do
    let(:code) { "alpha.beta" }

    it "stubs like a boss" do
      expect(stubber.befores).to match_array [
        "allow(obj).to receive(:alpha).and_return(alpha)",
        "allow(alpha).to receive(:beta).and_return(beta)",
      ]
    end

    it "has a legit human name" do
      expect(stubber.human_name).to eq "alpha.beta"
    end

    it "can create a test body" do
      expect(stubber.body).to match_array [
        "expect(obj).to have_received :alpha",
        "expect(alpha).to have_received :beta",
      ]
    end

    it "has some doubles" do
      expect(stubber.doubles).to match_array [:alpha, :beta]
    end
  end

  context "infinitely nested method calls" do
    let(:code) { "alpha.beta.gamma.delta" }

    it "stubs like a boss" do
      expect(stubber.befores).to match_array [
        "allow(obj).to receive(:alpha).and_return(alpha)",
        "allow(alpha).to receive(:beta).and_return(beta)",
        "allow(beta).to receive(:gamma).and_return(gamma)",
        "allow(gamma).to receive(:delta).and_return(delta)",
      ]
    end

    it "has a legit human name" do
      expect(stubber.human_name).to eq "alpha.beta.gamma.delta"
    end

    it "can create a test body" do
      expect(stubber.body).to match_array [
        "expect(obj).to have_received :alpha",
        "expect(alpha).to have_received :beta",
        "expect(beta).to have_received :gamma",
        "expect(gamma).to have_received :delta",
      ]
    end

    it "has some doubles" do
      expect(stubber.doubles).to match_array [:alpha, :beta, :gamma, :delta]
    end
  end
end
