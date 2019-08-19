# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'any2pdf'
  s.version = '1.2.1'
  s.platform = Gem::Platform::RUBY
  s.summary = "convert anything to pdf (via pandoc and pdfkit)"
  s.description = s.summary
  s.author = "Dominik Richter"
  s.email = "dominik.richter@gmail.com"

  s.add_dependency "pdfkit"
  s.add_dependency "css_parser"
  s.add_dependency "optimist"
  s.add_dependency "nokogiri"
  s.add_dependency "zlog"
  
  s.files = `git ls-files`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["data"]
end
