module Bookit
  class Content::Generic
    attr_accessor :attributes

    TYPES = {
      paragraph: Content::Paragraph,
      image:     Content::Image,
      header:    Content::Header,
      link:      Content::Link
    }
    
    # Content can always take options. These can usually be used 
    # to add additional formatting information for the Emitters
    def initialize(options={})
      @attributes = options
    end

    # #render for any Content object should always return a string
    # it is also possible to pass a block to render actions so that
    # you can fine-tune the content output from your Emitters
    def render
      inspect
    end

    # gives us an easy to compare type symbol
    def type
      self.class.to_s.split('::').last.downcase.to_sym
    end

    # returns true if this symbol is tied to the class type
    def is_type? sym
      self.class == TYPES[sym]
    end
  end
end

