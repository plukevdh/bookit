# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name        = "bookit"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY

  s.authors     = ["Luke van der Hoeven"]
  s.email       = ["hungerandthirst@gmail.com"]

  s.homepage    = "http://github.com/plukevdh/bookit"
  s.summary     = %q{BOOKS WHAT}
  s.description = %q{A quick way to format and output generic book information or articles in multiple formats. Mainly: PDF, EPUB and MOBI}

  s.rubyforge_project = "bookit"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # output
  s.add_dependency("prawn")
  s.add_dependency("eeepub")

  # parsing
  s.add_dependency("nokogiri")

  # storage
  s.add_dependency("redis")
end
