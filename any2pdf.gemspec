# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'any2pdf'
  s.version = '1.0.0'
  s.platform = Gem::Platform::RUBY
  s.summary = "convert anything to pdf (via pandoc and pdfkit)"
  s.description = s.summary
  s.author = "Dominik Richter"
  s.email = "dominik.richter@googlemail.com"  

  s.add_dependency "pdfkit"
  s.add_dependency "trollop"
  s.add_dependency "nokogiri"
  s.add_dependency "fileutils"
  s.add_dependency "zlog"
  
  s.files = `git ls-files`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["data"]
end
