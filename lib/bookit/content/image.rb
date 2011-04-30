module Bookit
  class Content
    class Image < Base
      attr_accessor :source

      def initialize(source, options={})
        @source = source

        super options
      end

      def render
        source
      end
    end
  end
end

