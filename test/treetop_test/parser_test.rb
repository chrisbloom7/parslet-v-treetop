require_relative '../test_helper'
require_relative '../../lib/treetop_test/parser'

class TreetopTestParserTest < Minitest::Test
  def setup
    @tree = TreetopTest::Parser.parse("A \"B C\" D:E F:\"G\" H")
  end

  def test_it_can_parse_a_string
    refute_nil @tree
  end

  # TODO: add `phrase` and `pos` fields
  def test_can_parse_a_tree_to_a_structured_query
    query = @tree.parse
    assert_equal query[0], { field: :default, value: "A", negation: false }
    assert_equal query[1], { field: :default, value: "B C", negation: false }
    assert_equal query[2], { field: :D, value: "E", negation: false }
    assert_equal query[3], { field: :F, value: "G", negation: false }
    assert_equal query[4], { field: :default, value: "H", negation: false }
  end
end
