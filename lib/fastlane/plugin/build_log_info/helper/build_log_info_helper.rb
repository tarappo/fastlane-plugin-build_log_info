module Fastlane
  module Helper
    class BuildLogInfoHelper
      class << self
        def summary_table(title:, headings:, rows:)
          Terminal::Table.new(
            title: title.to_s.green,
            headings: headings,
            rows: FastlaneCore::PrintTable.transform_output(rows)
          ).to_s
        end
      end
    end
  end
end
