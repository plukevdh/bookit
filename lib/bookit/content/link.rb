module Bookit
  class Content
    class Link < Base
      attr_accessor :url, :text

      def initialize(url, text, options={})
        @url = url
        @text = text

        super options
      end

      def output
        "#{text}: (#{url})"
      end
    end
  end
end

