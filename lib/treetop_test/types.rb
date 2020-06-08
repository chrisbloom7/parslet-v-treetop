require "byebug"

module TreetopTest
  module Dsl
    class ShallowParsedQuery < Treetop::Runtime::SyntaxNode
      def parse
        return self.elements.map { |x| x.parse }
      end
    end

    class QualifierNode < Treetop::Runtime::SyntaxNode
      def parse
        node = elements[2].parse
        node[:field] = elements[0].text_value.to_sym
        node
      end
    end

    class TermNode < Treetop::Runtime::SyntaxNode
      def parse
        {
          field: :default,
          value: text_value.strip,
          negation: false,
        }
      end
    end

    class PhraseNode < Treetop::Runtime::SyntaxNode
      def parse
        phrase = elements[1].text_value
        phrase.gsub!(/\\\"/, "\"")
        phrase.gsub!(/\\\\/, "\\")
        {
          field: :default,
          value: phrase,
          negation: false,
        }
      end
    end
  end
end

# pos:1, field:default, value:A, negation:false, phrase:false
