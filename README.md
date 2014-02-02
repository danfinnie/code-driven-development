# CodeDrivenDevelopment

Ever see a test and think, "wow, this test cares a lot about the exact abstract
syntax tree of the code?"  CDD aims to generate tests like that.  Here's some example input:

```
class Bunker < ActiveRecord::Base
  validate :password, secure: true
  validate :location, :protected => true

  def alert_staff
    Staff.alert_all
  end

  def alert_president
    SecretService.stand_down
    President.alert
  end
end
```

And this is what CDD thinks of it:

```
describe Bunker do
  it { should validate_secure_of :password }
  it { should validate_protected_of :location }
  
  describe #alert_staff do
    before do
      allow(Staff).to receive :alert_all
      described_class.new.alert_staff
    end
    it "calls Staff.alert_all" do
      expect(Staff).to have_received :alert_all
    end
  end
  
  describe #alert_president do
    before do
      allow(SecretService).to receive :stand_down
      allow(President).to receive :alert
      described_class.new.alert_president
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

    gem 'code-driven-development'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install code-driven-development

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
