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

  Scenario: boolean or
    Given a file named "my_feature.rb" with:
      """ruby
      class Yolounicorn
        def dilemma
          should_i_stay || should_i_go
        end
      end
      """
    When I run `cdd my_feature.rb`
    Then the exit status should be 0
    And the output should contain:
      """ruby
        describe "#dilemma" do
          let(:obj) { described_class.new }
          subject { obj.i_call_instance_methods }

          context "#should_i_stay is truthy" do
            before do
              allow(obj).to receive(:should_i_stay).and_return('should_i_stay')
              allow(obj).to receive(:should_i_go)
            end

            it "returns #should_i_stay" do
              expect(subject).to eq 'should_i_stay'
            end

            it "doesn't call #should_i_go" do
              subject
              expect(obj).not_to have_received :should_i_go
            end
          end

          context "#should_i_stay is falsey" do
            before do
              allow(obj).to receive(:should_i_stay).and_return(false)
              allow(obj).to receive(:should_i_go).and_return('should_i_go')
            end

            it "returns #should_i_go" do
              expect(subject).to eq 'should_i_go'
            end

            it "calls #should_i_stay" do
              subject
              expect(obj).to have_received :should_i_stay
            end
          end
        end
      """
