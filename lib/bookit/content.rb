# the Content class is an AST of sorts. it holds the generic structure
# of the article's content so that we can easily parse out important content
# attributes and then later output into other formats.

module Bookit
  class Content
    attr_reader :raw_content, :parser_class
    attr_accessor :formatted_content

    def initialize(raw_content, parser)
      @parser_class = parser
      @raw_content = raw_content
      @formatted_content = create_abstract
    end

    def create_abstract
      parser = @parser_class.send 'new'
      parser.parse(raw_content)
    end
  end
end
