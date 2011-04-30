module Bookit
  class Content::Base
    attr_accessor :attributes
    
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
  end
end

