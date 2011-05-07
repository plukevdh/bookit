$: << './lib/'
require 'bookit'

base = {
  content: File.read('./examples/article3.html'),
  author: "What?",
  title: "Who?",
  date_published: Time.now.to_s,
  url: "http://google.com"
}

a = Bookit::Article.new(base, Bookit::Parser::Html)

a.to_print(Bookit::Emitter::Epub)
