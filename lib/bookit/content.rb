# the Content class is an AST of sorts. it holds the generic structure
# of the article's content so that we can easily parse out important content
# attributes and then later output into other formats.

module Bookit
  class Content
    attr_reader :raw_content
    attr_accessor :formatted_content

    def self.define_render(type, &block)
      klass = Generic::TYPES[type]
      klass.define_method :render, block
    end

    def initialize(raw_content, parser)
      @raw_content = raw_content
      @formatted_content = parser.new.parse(raw_content)
    end

    # #render for any Content object should always return a string
    # it is also possible to pass a block to render actions so that
    # you can fine-tune the content output from your Emitters
    def render
      @formatted_content.each &:render
    end

  end
end
