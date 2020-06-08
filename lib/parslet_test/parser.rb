require_relative "dsl"

module ParsletTest
  class Parser
    def self.parse(data)
      Dsl::ShallowParsedQuery.new(Dsl.new.parse(data))
    rescue Parslet::ParseFailed => e
      raise Exception, e.parse_failure_cause.ascii_tree
    end
  end

  class Dsl::ShallowParsedQuery
    def initialize(tree)
      @tree = tree
    end

    def parse
      Transformer.new.apply(@tree)
    end
  end
end
