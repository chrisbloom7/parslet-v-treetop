require "treetop"

# Load our custom syntax node classes so the parser can use them
require_relative "dotcom_types"

class Parser
  # Find out what our base path is
  base_path = File.expand_path(File.dirname(__FILE__))

  # Load the Treetop grammar from the 'sexp_parser' file, and
  # create a new instance of that parser as a class variable
  # so we don't have to re-create it every time we need to
  # parse a string
  Treetop.load(File.join(base_path, "dotcom_dsl.treetop"))
  @@parser = DotcomDslParser.new

  def self.parse(data)
    # Pass the data over to the parser instance
    tree = @@parser.parse(data)

    # If the AST is nil then there was an error during parsing
    # we need to report a simple error message to help the user
    if(tree.nil?)
      raise Exception, "Parse error at offset: #{@@parser.index}"
    end

    return tree
  end
end

pp Parser.parse("keyword").parse
pp Parser.parse("key words").parse
pp Parser.parse('"phrase"').parse
pp Parser.parse('key "phrase" words').parse
pp Parser.parse("key \"ph\\\\ rase\\\"\" words").parse
pp Parser.parse('field:value').parse
pp Parser.parse('"field:value"').parse
