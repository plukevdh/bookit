module Bookit
  class Emitter
    class Abstract
      attr_accessor :article, :options

      DEFAULT_OPTIONS = {
        font_size: 12,
        
        header_size: 20,
        header_style: :bold,

        subtitle_size: 10,
        subtitle_style: :italic
      }

      def initialize(article, options={})
        @article = article
        @options = DEFAULT_OPTIONS.merge(options)
        
        # have all our type renderers raise an error unless defined in the subclass.
        Bookit::Content::TYPES.each do |type|
          self.class.send(:define_method, "render_#{type}".to_sym, -> { raise_abstract })
        end

      end  

      private
      def raise_abstract
        raise "Abstract class, please defined this to render for your filetype."
      end

    end
  end
end

