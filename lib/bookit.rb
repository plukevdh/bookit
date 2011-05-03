module Bookit
  require 'prawn'
  require 'eeepub'
  require 'redis'

  autoload :PersistableObject,  './bookit/persistable_object'
  autoload :Article,            './bookit/article'
  autoload :Parser,             './bookit/parser'
  autoload :Content,            './bookit/content'

  class Content
    autoload :Generic,          './bookit/content/generic'
    autoload :Paragraph,        './bookit/content/paragraph'
    autoload :Text,             './bookit/content/text'
    autoload :Link,             './bookit/content/link'
    autoload :Image,            './bookit/content/image'
    autoload :Header,           './bookit/content/header'
    autoload :List,             './bookit/content/list'
  end

  class Parser
    autoload :Html,             './bookit/parser/html'
  end

  class Emitter
    autoload :Base,             './bookit/emitter/base'
    autoload :Pdf,              './bookit/emitter/pdf'
  end
end

