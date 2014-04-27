# CodeDrivenDevelopment

Ever see a test and think, "wow, this test cares a lot about the exact abstract
syntax tree of the code?"  CDD aims to generate tests like that.  Here's some example input:

``` ruby
class Bunker < ActiveRecord::Base
  validate :password, secure: true
  validate :location, :protected => true

  def alert_staff
    staph.all_alert
    Staff.alert_all
  end

  def alert_president
    SecretService.stand_down
    alert_staff || go_crazy
  end
end
```

And this is what CDD thinks of it:

``` ruby
describe Bunker do
  it { should validate_secure_of :password }
  it { should validate_protected_of :location }
  describe "#alert_staff" do
    let(:obj) { described_class.new }
    let(:all_alert) { double(:all_alert) }
    let(:staph) { double(:staph) }
    let(:alert_all) { double(:alert_all) }
    subject { obj.alert_staff }
    before do
      allow(staph).to receive(:all_alert).and_return(all_alert)
      allow(obj).to receive(:staph).and_return(staph)
      allow(Staff).to receive(:alert_all).and_return(alert_all)
    end
    it "calls staph.all_alert" do
      subject
      expect(staph).to have_received :all_alert
      expect(obj).to have_received :staph
    end
    it "calls Staff.alert_all" do
      subject
      expect(Staff).to have_received :alert_all
    end
  end
  describe "#alert_president" do
    let(:obj) { described_class.new }
    let(:stand_down) { double(:stand_down) }
    subject { obj.alert_president }
    before do
      allow(SecretService).to receive(:stand_down).and_return(stand_down)
    end
    it "calls SecretService.stand_down" do
      subject
      expect(SecretService).to have_received :stand_down
    end
    describe "#alert_staff is truthy" do
      before do
        allow(obj).to receive(:alert_staff).and_return('alert_staff')
        allow(obj).to receive(:go_crazy)
      end
      it "returns #alert_staff" do
        expect(subject).to eq 'alert_staff'
      end
      it "doesn't call #go_crazy" do
        subject
        expect(obj).not_to have_received :go_crazy
      end
    end
    describe "#alert_staff is falsey" do
      before do
        allow(obj).to receive(:alert_staff).and_return(false)
        allow(obj).to receive(:go_crazy).and_return('go_crazy')
      end
      it "returns #go_crazy" do
        expect(subject).to eq 'go_crazy'
      end
      it "calls #alert_staff" do
        subject
        expect(obj).to have_received :alert_staff
      end
    end
  end
end
```

## Installation

Add this line to your application's Gemfile:

    gem 'code_driven_development'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install code_driven_development

## Usage

    $ cdd path/to/some/source.rb

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
