require './bookit/parser/html'

module Bookit
  class Article 
    BASE_ATTRS = [:author, :date_published, :url, :title]
    attr_accessor *BASE_ATTRS, :attributes, :content

    def initialize(attrs, parser=Bookit::Parser::Html)
      @attributes = {}

      @content = Content.new(attrs.delete('content'), parser) if attrs.include? 'content'

      BASE_ATTRS.each do |key|
        self.send "#{key}=", attrs[key.to_s]
        @attributes[key.to_sym] = attrs.delete key
      end

      @attributes.merge! attrs unless attrs.empty?
    end

    def method_missing(sym, *args, &block)
      if @attributes[sym.to_s]

        # cache the method
        self.class.class_eval do
          attr_accessor sym
        end

        self.send "#{sym}=", @attributes[sym.to_s]

        return @attributes.delete sym.to_s
      else
        super
      end
    end

    def to_pdf
      pdf = Prawn::Document.new
      pdf.font_size = 12

      pdf.text @title, size: 20, style: :bold
      pdf.text @author || "", size: 12, style: :bold
      pdf.text @date_published || "", size: 10
      pdf.text @url || "", size: 10
      pdf.text "\n\n"
      pdf.text @content
      
      pdf
    end

    def to_epub
      #not ready for this yet.
    end

    def to_mobi
      # not ready for this yet.
    end
  end
end
