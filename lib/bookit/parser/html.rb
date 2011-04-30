require 'nokogiri'

module Bookit
  class Parser
    class Html
      def parse(content)
        elements = []

        doc = Nokogiri::HTML(content)
        elements = walk(doc.root, [])
        
        elements.compact
      end

      def walk(element, tree)
        return tree if element.nil? || element.content.strip.empty?

        tree << case element.name
        when "p"
          Bookit::Content::Paragraph.new(walk_children(element, []))
        when "text"
          Bookit::Content::Text.new(element.content.strip)
        when "h1", "h2", "h3", "h4"
          Bookit::Content::Header.new(element.content.strip)
        when "a"
          Bookit::Content::Link.new(element.attributes["href"].value, walk_children(element, []))
        when "img"
          Bookit::Content::Image.new(element.attributes["src"].value)
        when "ul", "ol"
          Bookit::Content::List.new(walk_children(element, []))
        else
          walk_children(element, tree)
          nil
        end

        return tree
      end
      
      def walk_children(element, tree)
        element.children.inject(tree) {|past, child| walk(child, past)}
      end
    end
  end
end
