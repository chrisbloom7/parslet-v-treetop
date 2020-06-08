require "parslet"

module ParsletTest
  class Dsl < Parslet::Parser
    rule(:quoted_character) { str('\\"') | str('\\\\') | match['^"\\\\'] }
    rule(:space) { match[' \t'].repeat(1) }
    rule(:keyword) do
      (
        match['a-zA-Z'].repeat(1) >>
        space.maybe.ignore
      ).as(:keyword)
    end
    rule(:phrase) do
      (
        str('"').ignore >>
        quoted_character.repeat(1) >>
        str('"').ignore >>
        space.maybe.ignore
      ).as(:phrase)
    end
    rule(:term) { phrase | keyword }
    rule(:qualifier_field) { match['a-zA-Z'].repeat(1).as(:field) }
    rule(:qualifier) do
      (
        qualifier_field >>
        str(':') >>
        term
      ).as(:qualifier)
    end
    rule(:query) { ( qualifier | term ).repeat(1) }
    root :query
  end

  class DotcomTransformer < Parslet::Transform
    rule(qualifier: { field: simple(:field), keyword: simple(:term) }) do
      {
        pos: field.offset,
        field: field.to_sym,
        value: term.to_s,
        negation: false,
        phrase: false,
      }
    end

    rule(qualifier: { field: simple(:field), phrase: simple(:term) }) do
      phrase = term.to_s.gsub(/\\\"/, "\"").gsub(/\\\\/, "\\")
      {
        pos: field.offset,
        field: field.to_sym,
        value: phrase,
        negation: false,
        phrase: true,
      }
    end

    rule(keyword: simple(:term)) do
      {
        pos: term.offset,
        field: :default,
        value: term.to_s,
        negation: false,
        phrase: false,
      }
    end

    rule(phrase: simple(:term)) do
      offset = term.offset
      phrase = term.to_s.gsub(/\\\"/, "\"").gsub(/\\\\/, "\\")
      {
        pos: offset,
        field: :default,
        value: phrase,
        negation: false,
        phrase: true,
      }
    end
  end

  class SimpleDsl < Parslet::Parser
    rule(:term) { match['a-zA-Z0-9'].repeat(1) }
    rule(:space) { match('\s').repeat(1) }
    rule(:query) { ( term >> space.maybe ).repeat(1) }
    root(:query)
  end
end
