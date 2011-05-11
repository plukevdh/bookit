require 'tempfile'

module Bookit
  class Emitter
    class Mobi < Abstract
      def generate
        tfile = Tempfile.new(["temp", ".html"])
        tfile.write %{
          <!DOCTYPE html> 
          <html>
            <metadata>
              <dc:Title>#{@article.title}</dc:Title>
            </metadata>
            <body>
              <h1>#{@article.title}</h1>
              <b>#{@article.author}</b>
              <br/>
              <i>
                  #{@article.date_published}
                  <br/>
                  #{@article.url}
              </i>
              <br/>
              #{@article.content.raw_content}
            </body>
          </html>
        }

        tfile.close
        @path = tfile.path

        `kindlegen -c2 #{@path} -o out.mobi`
        self
      end

      def filepath
        File.join(File.dirname(@path), 'out.mobi')
      end

      def render
        IO.binread(filepath)
      end

      def save(filename)
        File.open(filename, 'w') do |f|
          f << File.read(filepath)
        end
      end
    end
  end
end
