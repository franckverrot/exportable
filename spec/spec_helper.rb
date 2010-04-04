begin
  require 'spec'
  require 'spec/test/unit'
  require 'yaml'
rescue LoadError
  require 'rubygems' unless ENV['NO_RUBYGEMS']
  gem 'rspec'
  require 'spec'
  require 'spec/test/unit'
  require 'yaml'
end

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'exportable'

module ExportableTests
  class User
    attr_accessor :firstname, :lastname, :email
  end

  def ExportableTests.dataset
    ds = []
    YAML.load_file('fixtures/users.yaml').each do |k,v|
      ds << User.new.tap do |u|
        u.email     = v[:email]
        u.lastname  = v[:lastname]
        u.firstname = v[:firstname]
      end
    end
    ds
  end
end

