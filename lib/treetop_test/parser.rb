require "treetop"

# Load our custom syntax node classes so the parser can use them
require_relative "types"

module TreetopTest
  class Parser
    base_path = File.expand_path(File.dirname(__FILE__))
    Treetop.load(File.join(base_path, "dsl.treetop"))

    def self.parse(data)
      parser = DslParser.new
      tree = parser.parse(data)
      raise Exception, "Parse error at offset: #{parser.index}" if tree.nil?
      tree
    end
  end
end
