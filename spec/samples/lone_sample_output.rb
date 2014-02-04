describe Lolcat do
	it { should validate_presence_of :cuteness }
	
	describe "#i_call_things" do
		let(:obj) { described_class.new }
		before do
			allow(CentralBureaucracy).to receive :file_report
			obj.i_call_things
		end
		it "calls CentralBureaucracy.file_report" do
			expect(CentralBureaucracy).to have_received :file_report
		end
	end
	
	describe "#i_call_instance_methods" do
		let(:obj) { described_class.new }
		before do
			allow(obj).to receive :meth
			obj.i_call_instance_methods
		end
		it "calls #meth" do
			expect(obj).to have_received :meth
		end
	end
end
