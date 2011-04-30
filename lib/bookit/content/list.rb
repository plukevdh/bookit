module Bookit
  class Content
    class List < Base
      attr_accessor :items

      # a List could contain text or links.
      def initialize(items, options={})
        @items = items

        super options
      end

      def render
        output = @items.map &:render
        block_given? ? yield(output) : output.join("\n")
      end
    end
  end
end

