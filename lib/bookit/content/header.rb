module Bookit
  class Content
    class Header < Generic
      attr_accessor :text

      # headers will only ever contain text, but usually contained separately
      # for formatting purposes
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
