require 'fastlane_core/ui/ui'
require 'terminal-table'

module Fastlane
  module Helper
    class BuildLogInfoHelper
      class << self

        def summary_table(title:, headings:, rows:)
          Terminal::Table.new(
              title: "#{title}".green,
              headings: headings,
              rows: FastlaneCore::PrintTable.transform_output(rows),
          ).to_s
        end

      end
    end
  end
end
