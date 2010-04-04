# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
require 'exportable'
 
Gem::Specification.new do |s|
  s.name        = "exportable"
	s.version     = Exportable::VERSION
	s.authors     = ["Franck \"Cesario\"Verrot"]
	s.email       = %q{franck.verrot@gmail.com}
  s.homepage    = "http://github.com/cesario/exportable"
	s.summary     = %q{Tired of writting again and again how to export data into various file formats? Then acts_as_exportable is for you.}
	s.description = %q{Tired of writting again and again how to export data into various file formats? Then acts_as_exportable is for you.}
 
  s.rubyforge_project         = "exportable"
	s.has_rdoc = true
 
  s.add_development_dependency "rspec"
 
  s.files        = Dir.glob("{bin,lib}/**/*") + %w(MIT_LICENSE README.md ROADMAP.md CHANGELOG.md)
  s.require_path = 'lib'
end
