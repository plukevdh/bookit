module Bookit
  class Content

    # Content that will be clickable to web urls. Can be images or text.
    class Link < Base
      attr_accessor :url, :text

      def initialize(url, objects, options={})
        @url = url
        @objects = (objects === Array) ? objects : [objects]

        super options
      end

      def render
        output = [@url, @objects.map(&:render)]
        block_given? ? yield(output) : output.flatten.join(":")
      end
    end
  end
end

