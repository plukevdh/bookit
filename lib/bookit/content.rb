# the Content class is an AST of sorts. it holds the generic structure
# of the article's content so that we can easily parse out important content
# attributes and then later output into other formats.

module Bookit
  class Content
    attr_reader :raw_content
    attr_accessor :formatted_content

    autoload :Generic,          'bookit/content/generic'
    autoload :Paragraph,        'bookit/content/paragraph'
    autoload :Text,             'bookit/content/text'
    autoload :Link,             'bookit/content/link'
    autoload :Image,            'bookit/content/image'
    autoload :Header,           'bookit/content/header'
    autoload :List,             'bookit/content/list'

    TYPES = {
      paragraph: Content::Paragraph,
      image:     Content::Image,
      header:    Content::Header,
      link:      Content::Link,
      list:      Content::List
    }

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
