require 'fastlane/action'
require_relative '../helper/xchtmlreport_helper'

module Fastlane
  module Actions
    class XchtmlreportAction < Action
      def self.run(params)
        binary_path = params[:binary_path]
        unless File.file?(binary_path)
          UI.user_error!('xchtmlreport binary not installed! https://github.com/TitouanVanBelle/XCTestHTMLReport')
        end

        result_bundle_path = params[:result_bundle_path]
        if result_bundle_path.nil?
          result_bundle_path = Scan.cache[:result_bundle_path]
        end

        result_bundle_paths = params[:result_bundle_paths]
        if result_bundle_path && result_bundle_paths.empty?
          result_bundle_paths = [result_bundle_path]
        end

        if result_bundle_paths.nil? || result_bundle_paths.empty?
          UI.user_error!('You must pass at least one result_bundle_path')
        end

        UI.message("Result bundle path: #{result_bundle_path}")

        command_comps = [binary_path]
        command_comps += result_bundle_paths.map { |path| "-r #{path}" }
        command_comps.append('-j') if params[:enable_junit]

        sh(command_comps.join(' '))
      end

      def self.description
        'Xcode-like HTML report for Unit and UI Tests'
      end

      def self.authors
        ['XCTestHTMLReport: TitouanVanBelle', 'plugin: chrisballinger']
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        'https://github.com/TitouanVanBelle/XCTestHTMLReport'
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(
            key: :result_bundle_path,
            description: 'Path to the result bundle from scan. After running scan you can use Scan.cache[:result_bundle_path]',
            conflicting_options: [:result_bundle_paths],
            optional: true,
            is_string: true,
            conflict_block: proc do |value|
              UI.user_error!("You can't use 'result_bundle_path' and 'result_bundle_paths' options in one run")
            end,
            verify_block: proc do |value|
              UI.user_error!("Bad path to the result bundle given: #{value}") unless value && File.directory?(value)
            end
          ),

          FastlaneCore::ConfigItem.new(
            key: :result_bundle_paths,
            description: "Array of multiple result bundle paths from scan",
            conflicting_options: [:result_bundle_path],
            optional: true,
            default_value: [],
            type: Array,
            conflict_block: proc do |value|
              UI.user_error!("You can't use 'result_bundle_path' and 'result_bundle_paths' options in one run")
            end,
            verify_block: proc do |value|
              value.each do |path|
                UI.user_error!("Bad path to the result bundle given: #{path}") unless path && File.directory?(path)
              end
            end
          ),

          FastlaneCore::ConfigItem.new(
            key: :binary_path,
            description: "Path to xchtmlreport binary",
            is_string: true, # true: verifies the input is a string, false: every kind of value
            default_value: "/usr/local/bin/xchtmlreport"
          ), # the default value if the user didn't provide one

          FastlaneCore::ConfigItem.new(
            key: :enable_junit,
            default_value: false,
            description: "Enables JUnit XML output 'report.junit'",
            optional: true
          )
        ]
      end

      def self.is_supported?(platform)
        [:ios, :mac].include?(platform)
      end
    end
  end
end
