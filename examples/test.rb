$: << '../lib/'
require 'bookit'

base = {
  content: File.read('article2.html'),
  author: "What?",
  title: "Who?",
  date_published: Time.now.to_s,
  url: "http://google.com"
}

a = Bookit::Article.new(base, Bookit::Parser::Html)

content = a.to_print(Bookit::Emitter::Mobi).render
puts content

