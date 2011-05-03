require 'prawn'
require 'prawn/measurement_extensions'

module Bookit
  class Emitter
    class Pdf < Abstract
      def generate
        @pdf = Prawn::Document.new(info: {
          :Title => @article.title,
          :CreationDate => @article.date_published,
          :Author => @article.author,
          :Source => @article.url }, 
          margin: 0.5.in, page_size: 'LEGAL')

        @pdf.font_size = options[:font_size]

        @pdf.text @article.title, size: options[:header_size], style: options[:header_style]
        @pdf.text @article.author, style: :bold
        
        @pdf.text @article.date_published, size: options[:subtitle_size], style: options[:subtitle_style]
        @pdf.text @article.url, size: options[:subtitle_size], style: options[:subtitle_style]
        
        @pdf.text "\n\n"
        
        @article.content.formatted_content.each do |item|
          output(render(item))
        end

        @pdf
      end

      private
      def render(item)
        send "render_#{item.type}", item.render
      end

      def output(group)
        group[2] = {inline_format: true}
        @pdf.send *group.flatten
        @pdf.text("\n")
      end

      def render_paragraph(items)
        ["text", items.map {|i| render(i)[1..-1]}.join(" ")]
      end 

      def render_text(text)
        ["text", text]
      end

      # render images on finding them. not embeddable within a paragraph for now.
      def render_image(img)
        @pdf.image *img
        ["text"]
      end

      def render_header(text)
        ["text", text, size: options[:header_size]]
      end

      def render_list(items)
        ["text", items.map {|i| "- #{render(i)[1..-1].join(" ")}"}.join("\n")]
      end

      def render_link(link)
        ["text", "<color rgb='#0000ff'><u><link href='#{link[0]}'>#{link[1].join("")}</link></u></color>"]
      end

    end
  end
end
