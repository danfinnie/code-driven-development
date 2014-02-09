Feature: Creates awesome specs
  Scenario: creating shoulda_matchers
    Given a file named "my_feature.rb" with:
      """ruby
      class Lolcat < ActiveRecord::Base
        validate :cuteness, presence: true
      end
      """
    When I run `cdd my_feature.rb`
    Then the exit status should be 0
    And the output should contain:
      """ruby
      describe Lolcat do
        it { should validate_presence_of :cuteness }
      end
      """

  Scenario: instance methods that call constants
    Given a file named "my_feature.rb" with:
      """ruby
      class Lolcat
        def i_call_things
          CentralBureaucracy.file_report
        end
      end
      """
    When I run `cdd my_feature.rb`
    Then the exit status should be 0
    And the output should contain:
      """ruby
        describe "#i_call_things" do
          let(:obj) { described_class.new }
          subject { obj.i_call_things }
          before do
            allow(CentralBureaucracy).to receive :file_report
          end
          it "calls CentralBureaucracy.file_report" do
            subject
            expect(CentralBureaucracy).to have_received :file_report
          end
        end
      """

  Scenario: instance methods that call instance methods
    Given a file named "my_feature.rb" with:
      """ruby
      class Lolcat
        def i_call_instance_methods
          meth
        end
      end
      """
    When I run `cdd my_feature.rb`
    Then the exit status should be 0
    And the output should contain:
      """ruby
        describe "#i_call_instance_methods" do
          let(:obj) { described_class.new }
          subject { obj.i_call_instance_methods }
          before do
            allow(obj).to receive :meth
          end
          it "calls #meth" do
            subject
            expect(obj).to have_received :meth
          end
        end
      """
