module Bookit
  class Content
    class Image
      attr_accessor :source

      # takes a source url
      def initialize(source, options={})
        @source = source

        super options
      end

      # returns the url to the image
      def render
        block_given? ? yield(source) : source
      end
    end
  end
end

