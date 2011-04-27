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
        return tree if element.nil?

        tree << case element.name
        when "text"
          Bookit::Content::Paragraph.new(element.content)
        when "h1", "h2", "h3", "h4"
          Bookit::Content::Header.new(element.content)
        when "a"
          Bookit::Content::Link.new(element.attributes["href"].value, 
                                            element.content)
        when "img"
          Bookit::Content::Image.new(element.attributes["src"].value)
        when "ul", "ol"
          Bookit::Content::List.new(element.children.map(&:content))
        end
        
        element.children.each {|child| walk(child, tree)}
        return tree
      end
    end
  end
end
