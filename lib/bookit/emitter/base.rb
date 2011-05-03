module Bookit
  class Emitter
    class Base
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
        define_render_outputs
      end

      private
      def define_render_outputs
        raise "Base Emitter - no output types defined"
      end
    end
  end
end

