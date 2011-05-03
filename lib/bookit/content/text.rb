module Bookit
  class Content
    class Text < Generic
      attr_accessor :text

      def initialize(text, options={})
        @text = text

        super options
      end

      def render
        text
      end
    end
  end
end


