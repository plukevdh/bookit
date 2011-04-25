module Bookit
  require 'prawn'
  require 'eeepub'
  require 'redis'

  autoload :PersistableObject, 'bookit/persistable_object'
  autoload :Article, 'bookit/article'
end
