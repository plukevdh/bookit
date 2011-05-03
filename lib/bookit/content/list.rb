module Bookit
  class Content
    class List < Generic
      attr_accessor :items

      # a List could contain text or links.
      def initialize(items, options={})
        @items = (items.class == Array) ? items : [items]

        super options
      end

      def render
        output = @items.map &:render
        block_given? ? yield(output) : output.join("\n")
      end
    end
  end
end

