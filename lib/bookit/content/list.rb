module Bookit
  class Content
    class List < Generic
      attr_accessor :items

      # a List could contain text or links.
      def initialize(items, options={})
        items.compact!
        @items = (items.class == Array) ? items : [items]

        super options
      end

      def render
        @items
      end
    end
  end
end

