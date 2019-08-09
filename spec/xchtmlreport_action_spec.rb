describe Fastlane::Actions::XchtmlreportAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The xchtmlreport plugin is working!")

      Fastlane::Actions::XchtmlreportAction.run(nil)
    end
  end
end
