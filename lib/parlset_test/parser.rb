require_relative "dotcom_dsl"

module ParsletTest
  class Parser
    def self.parse(data)
      Dsl.new.parse(data)
    rescue Parslet::ParseFailed => failure
      puts failure.parse_failure_cause.ascii_tree
    end
  end
end
