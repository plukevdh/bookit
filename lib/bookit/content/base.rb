module Bookit
  class Content::Base
    attr_accessor :attributes
    def initialize(options={})
      @attributes = options
    end

    def render
      inspect
    end
  end
end

