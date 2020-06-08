require "treetop"

# Load our custom syntax node classes so the parser can use them
require_relative "types"

module TreetopTest
  class Parser
    # Find out what our base path is
    base_path = File.expand_path(File.dirname(__FILE__))

    # Load the Treetop grammar from the 'sexp_parser' file, and
    # create a new instance of that parser as a class variable
    # so we don't have to re-create it every time we need to
    # parse a string
    Treetop.load(File.join(base_path, "dsl.treetop"))
    @@parser = DslParser.new

    def self.parse(data)
      # Pass the data over to the parser instance
      tree = @@parser.parse(data)

      # If the AST is nil then there was an error during parsing
      # we need to report a simple error message to help the user
      raise Exception, "Parse error at offset: #{@@parser.index}" if tree.nil?

      tree
    end
  end
end
