require 'fastlane/action'
require_relative '../helper/build_log_info_helper'
require 'json'

module Fastlane
  module Actions
    class BuildLogInfoAction < Action
      def self.run(params)
        begin
          path = params[:file_path]
          @json_data = JSON.parse(File.open(path).read)
        rescue => error
          UI.user_error!("JSON File Error:#{error.message}")
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
            summary_rows << [key.to_s.red, value.to_s.red]
          else
            summary_rows << [key, value.to_s.green]
          end
        end

        # summary
        summary_table = Helper::BuildLogInfoHelper.summary_table(
          title: "Summary",
          headings: %w[Key Num],
          rows: summary_rows
        )
        puts(summary_table)

        # detail
        all_keys.each do |key|
          rows = []

          @json_data[key].each do |line|
            rows << [line["file_path"], line["reason"]]
          end

          title_num = @json_data[key].size

          # if num is 0 then do not display
          next if title_num == 0

          # if skip table then do not display
          next if params[:skip_summary_types].include?(key)

          # detail table
          summary_table = Helper::BuildLogInfoHelper.summary_table(
            title: "#{key} #{title_num}",
            headings: %w[FilePath Reason],
            rows: rows
          )
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
          FastlaneCore::ConfigItem.new(key: :file_path,
                                       env_name: 'FILE_PATH',
                                       description: 'Path to result json file. ',
                                       default_value: Dir['./build/reports/*.json'].last,
                                       optional: true,
                                       verify_block: proc do |value|
                                         raise "Couldn't find file".red unless File.exist?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :skip_summary_types,
                                       env_name: 'SKIP_SUMMARY_TYPES',
                                       description: 'skip show summary table. ',
                                       default_value: [],
                                       is_string: false,
                                       optional: true)
        ]
      end

      def self.is_supported?(platform)
        [:ios].include?(platform)
      end
    end
  end
end
