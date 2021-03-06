module Bookit
  require 'prawn'
  require 'eeepub'
  require 'redis'

  autoload :PersistableObject,  'bookit/persistable_object'
  autoload :Article,            'bookit/article'
  autoload :Parser,             'bookit/parser'
  autoload :Content,            'bookit/content'

  class Content
    autoload :Generic,          'bookit/content/generic'
  end

  class Parser
    autoload :Html,             'bookit/parser/html'
  end

  class Emitter
    autoload :Abstract,         'bookit/emitter/abstract'
    autoload :Pdf,              'bookit/emitter/pdf'
    autoload :Epub,             'bookit/emitter/epub'
    autoload :Mobi,             'bookit/emitter/mobi'
  end
end

