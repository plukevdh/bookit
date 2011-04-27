module Bookit
  class Content::Base
    attr_accessor :attributes
    def initialize(options={})
      @attributes = options
    end

    def output
      inspect
    end
  end
end

