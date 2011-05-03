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
          :Source => @article.url }, 
          margin: 0.5.in, page_size: 'LEGAL')

        pdf.font_size = options[:font_size]

        pdf.text @article.title, size: options[:header_size], style: options[:header_style]
        pdf.text @article.author, style: :bold
        
        pdf.text @article.date_published, size: options[:subtitle_size], style: options[:subtitle_style]
        pdf.text @article.url, size: options[:subtitle_size], style: options[:subtitle_style]
        
        pdf.text "\n\n"
        
        @article.content.render
        pdf
      end

      private
      def define_render_outputs
        define_render :paragraph {|items|  pdf.text items}
        define_render :image {|source| pdf.image open(source)}
        define_render :header {|text| pdf.text text, size: options[:header_size]}
        define_render :link {|url, linkable| pdf.text "<color rgb='#0000ff'><u><link href='#{url}'>#{linkable}</link></u></color>", inline_format: true}
        define_render :list {|items| items.each {|i| pdf.text "- #{i}"} }
      end
    end
  end
end
