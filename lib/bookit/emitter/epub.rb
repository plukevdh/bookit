require 'tempfile'

module Bookit
  class Emitter
    class Epub < Abstract
      def generate
        tfile = Tempfile.new(["temp", ".html"])
        tfile.write %{
          <!DOCTYPE html> 
          <html>
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

        data = @article
        epub = EeePub.make do
          title       data.title
          date        data.date_published
          creator     data.author
          identifier  data.url, scheme: "URL"
          uid         data.url
          
          files       [File.expand_path(tfile.path)]
        end

        epub
      end
    end
  end
end

