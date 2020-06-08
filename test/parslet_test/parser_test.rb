require_relative '../test_helper'
require_relative '../../lib/parslet_test/parser'

class ParsletTestParserTest < Minitest::Test
  def setup
    @tree = ParsletTest::Parser.parse("A \"B C\" D:E F:\"G\" H")
  end

  def test_it_can_parse_a_string
    refute_nil @tree
  end

  def test_can_parse_a_tree_to_a_structured_query
    query = @tree.parse
    assert_equal query[0], {
      pos: 0, field: :default, value: "A", negation: false, phrase: false
    }
    assert_equal query[1], {
      pos: 3, field: :default, value: "B C", negation: false, phrase: true
    }
    assert_equal query[2], {
      pos: 8, field: :D, value: "E", negation: false, phrase: false
    }
    assert_equal query[3], {
      pos: 12, field: :F, value: "G", negation: false, phrase: true
    }
    assert_equal query[4], {
      pos: 18, field: :default, value: "H", negation: false, phrase: false
    }
  end
end
