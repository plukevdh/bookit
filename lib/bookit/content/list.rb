module Bookit
  class Content
    class List < Base
      attr_accessor :items

      def initialize(items, options={})
        @items = items

        super options
      end

      def output
        "list: #{items.join(", ")}"
      end
    end
  end
end

