require 'scan'

describe Fastlane::Actions::XchtmlreportAction do
  describe '#run' do
    before(:all) do
      options = { project: File.expand_path('./spec/fixtures/app.xcodeproj') }
      Scan.config = FastlaneCore::Configuration.create(Scan::Options.available_options, options)
      Scan.cache[:result_bundle_path] = '/var/folders/non_existent_file.test_result'
    end

    before :each do
      allow(File).to receive(:directory?).and_call_original
    end

    it 'works with default binary path' do
      path = 'Test.test_result'
      allow(File).to receive(:directory?).with(path).and_return(true)

      result = Fastlane::FastFile.new.parse("lane :test do
        xchtmlreport({
          result_bundle_path: '#{path}'
        })
      end").runner.execute(:test)

      expect(result).to eq("/usr/local/bin/xchtmlreport -r '#{path}'")
    end

    it 'works with custom binary path' do
      allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(nil)
      path = 'Test.test_result'
      allow(File).to receive(:directory?).with(path).and_return(true)

      result = Fastlane::FastFile.new.parse("lane :test do
        xchtmlreport({
          result_bundle_path: '#{path}',
          binary_path: './spec/fixtures/xchtmlreport'
        })
      end").runner.execute(:test)

      expect(result).to eq("./spec/fixtures/xchtmlreport -r '#{path}'")
    end

    it 'works with multiple result bundles' do
      paths = ['Foo.test_result', 'Bar.test_result']
      paths.each do |path|
        allow(File).to receive(:directory?).with(path).and_return(true)
      end

      result = Fastlane::FastFile.new.parse("lane :test do
        xchtmlreport({
          result_bundle_paths: #{paths}
        })
      end").runner.execute(:test)

      expect(result).to eq("/usr/local/bin/xchtmlreport -r 'Foo.test_result' -r 'Bar.test_result'")
    end

    it 'works with spaces in paths' do
      path = 'spec/fixtures/My First App.test_result'
      allow(File).to receive(:directory?).with(path).and_return(true)

      result = Fastlane::FastFile.new.parse("lane :test do
        xchtmlreport({
          result_bundle_path: '#{path}'
        })
      end").runner.execute(:test)

      expect(result).to eq("/usr/local/bin/xchtmlreport -r '#{path}'")
    end

    it 'works with JUnit XML output enabled' do
      path = 'spec/fixtures/Test.test_result'
      allow(File).to receive(:directory?).with(path).and_return(true)

      result = Fastlane::FastFile.new.parse("lane :test do
        xchtmlreport({
          result_bundle_path: '#{path}',
          enable_junit: true
        })
      end").runner.execute(:test)

      expect(result).to eq("/usr/local/bin/xchtmlreport -r '#{path}' -j")
    end

    it 'works with additional logs enabled' do
      path = 'Test.test_result'
      allow(File).to receive(:directory?).with(path).and_return(true)

      result = Fastlane::FastFile.new.parse("lane :test do
        xchtmlreport({
          result_bundle_path: '#{path}',
          verbose: true
        })
      end").runner.execute(:test)

      expect(result).to eq("/usr/local/bin/xchtmlreport -r '#{path}' -v")
    end
  end
end
