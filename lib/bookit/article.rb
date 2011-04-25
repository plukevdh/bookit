module Bookit
  class Article < PersistableObject
    REQUIRED_ATTRS = [:author, :publish_date, :url, :content, :title]
    attr_accessor *REQUIRED_ATTRS, :attributes

    key 'bookit:article'

    class << self

    end

    def initialize(attrs)
      @attributes = {}

      REQUIRED_ATTRS.each do |key|
        self.send "#{key}=", attrs[key.to_s]
        @attributes[key.to_sym] = attrs.delete key
      end

      @attributes.merge! attrs unless attrs.empty?
    end

    def to_pdf
      Prawn::Document.generate "#{title} - #{author}.pdf" do 
        self.font_size = 12

        text title, size: 20, style: :bold
        text author, size: 12, style: :bold
        font_size 10 do
          text publish_date
          text url
        end

        text content
      end
    end

    def to_epub
      #not ready for this yet.
    end

    def to_mobi
      # not ready for this yet.
    end

  end
end
