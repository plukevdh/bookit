module Bookit
  class Content
    class Paragraph < Generic
      attr_accessor :contents

      # Paragraph can contain most other object types. Text, images or links.
      def initialize(contents, options={})
        # this could be an array of images, text, links or just a single element
        contents.compact!
        @contents = (contents.class == Array) ? contents : [contents]

        super options
      end

      def render 
        @contents
      end
    end
  end
end


