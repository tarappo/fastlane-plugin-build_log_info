require 'fastlane/action'
require_relative '../helper/build_log_info_helper'
require 'json'

module Fastlane
  module Actions
    class BuildLogInfoAction < Action
      def self.run(params)
        #TODO: need simply
        dir_path = File.expand_path('../../../../../', File.dirname(__FILE__))
        path = ENV["XCPRETTY_JSON_FILE_OUTPUT"] ||= "#{dir_path}/build/reports/errors.json"

        begin
          File.open(path) do |json|
            @json_data = JSON.parse(json)
          end
        rescue => error
          UI.user_error!(error.message)
        end

        all_keys = %w[warnings ld_warnings compile_warnings errors
                      compile_errors file_missing_errors
                      undefined_symbols_errors duplicate_symbols_errors
                      tests_failures tests_summary_messages]

        # summary
        summary_rows = []
        all_keys.each do |key|
          value = @json_data[key].size

          if value > 0
            summary_rows << ["#{key}".red, "#{value}".red]
          else
            summary_rows << [key, "#{value}".green]
          end

          key_num = "#{key}_num"
          eval "@#{key_num}=#{value}"
        end

        # summary
        puts ("")
        summary_table = Helper::BuildLogInfoHelper.summary_table(
            title: "Summary",
            headings: ["Key", "Num"],
            rows: summary_rows)
        puts(summary_table)


        # detail
        all_keys.each do |key|
          rows = []

          @json_data[key].each do |line|
            rows << ["filePath", line["file_path"], line["reason"]]
          end

          title_num = eval "@#{key}_num"

          # if num is 0 then do not display
          next if title_num == 0

          # detail table
          puts ("")
          summary_table = Helper::BuildLogInfoHelper.summary_table(
              title: "#{key} #{title_num}",
              headings: ["Key", "FilePath", "Reason" ],
              rows: rows)
          puts(summary_table)
        end
      end

      def self.description
        "build log information"
      end

      def self.authors
        ["tarappo"]
      end

      def self.return_value
      end

      def self.details
        "build log information"
      end

      def self.available_options
        [
        ]
      end

      def self.is_supported?(platform)
        [ :ios ].include?(platform)
      end
    end
  end
end
