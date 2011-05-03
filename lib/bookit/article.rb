require 'bookit/parser/html'
require 'bookit/emitter/pdf'

module Bookit
  class Article 
    REQUIRED_ATTRS = [:author, :date_published, :url, :title, :content]
    attr_accessor *REQUIRED_ATTRS, :attributes

    def initialize(attrs, parser=Bookit::Parser::Html)
      @attributes = attrs.dup

      REQUIRED_ATTRS.each do |key|
        raise "Required attribute #{key} not found." unless @attributes[key]
        self.send "#{key}=", @attributes[key]
      end

      # parse raw content into array of generic content
      @content = Content.new(@content, parser)
    end

    # Article's to print method outputs the given input content into the given
    # emitter document type. We output PDF by default.
    def to_print(emitter=Bookit::Emitter::Pdf)
      emitter.new(self).generate
    end
  end
end
