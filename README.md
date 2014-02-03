# CodeDrivenDevelopment

Ever see a test and think, "wow, this test cares a lot about the exact abstract
syntax tree of the code?"  CDD aims to generate tests like that.  Here's some example input:

``` ruby
class Bunker < ActiveRecord::Base
  validate :password, secure: true
  validate :location, :protected => true

  def alert_staff
    Staff.alert_all
  end

  def alert_president
    alert_staff
    SecretService.stand_down
    President.alert
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
    before do
      allow(Staff).to receive :alert_all
      obj.alert_staff
    end
    it "calls Staff.alert_all" do
      expect(Staff).to have_received :alert_all
    end
  end

  describe "#alert_president" do
    let(:obj) { described_class.new }
    before do
      allow(obj).to receive :alert_staff
      allow(SecretService).to receive :stand_down
      allow(President).to receive :alert
      obj.alert_president
    end
    it "calls #alert_staff" do
      expect(obj).to have_received :alert_staff
    end
    it "calls SecretService.stand_down" do
      expect(SecretService).to have_received :stand_down
    end
    it "calls President.alert" do
      expect(President).to have_received :alert
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

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
