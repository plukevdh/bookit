require 'open-uri'

module Bookit
  class Content
    class Image < Generic
      attr_accessor :source

      # takes a source url
      def initialize(source, options={})
        @source = source

        super options
      end

      # returns the url to the image
      def render
        [open(source), attributes]
      end
    end
  end
end

