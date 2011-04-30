require 'prawn'
require 'open-uri'
require 'prawn/measurement_extensions'

module Bookit
  class Emitter
    class Pdf < Base
      def generate
        pdf = Prawn::Document.new(info: {
          :Title => @article.title,
          :CreationDate => @article.date_published,
          :Author => @article.author,
          :Source => @article.url}, 
          margin: 0.5.in, page_size: 'LEGAL')

        pdf.font_size = options[:font_size]

        pdf.text @article.title, size: options[:header_size], style: options[:header_style]
        pdf.text @article.author, style: :bold
        
        pdf.text @article.date_published, size: options[:subtitle_size], style: options[:subtitle_style]
        pdf.text @article.url, size: options[:subtitle_size], style: options[:subtitle_style]
        
        pdf.text "\n\n"
        
        @article.content.formatted_content.each do |item|
          case item
          when Bookit::Content::Paragraph
            pdf.text item.render
          when Bookit::Content::Image
            pdf.image open(item.render)
          when Bookit::Content::Header
            pdf.text item.render, size: options[:header_size]
          when Bookit::Content::Link
            pdf.text "<color rgb='#0000ff'><u><link href='#{item.url}'>#{item.text}</link></u></color>", inline_format: true
          when Bookit::Content::List
            pdf.text item.items.join(", ")
          end
        end

        pdf
      end
    end
  end
end
