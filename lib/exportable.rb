$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
require 'extensions/csv'
require 'extensions/empty'

module Exportable
  VERSION = '0.0.2'
  SUPPORTED_EXTENSIONS = { :csv => ExportableExtensions::Csv, :demo => ExportableExtensions::Empty }

  def self.included(base)
    base.extend ClassMethods
  end


  module ClassMethods
    $exportable_settings = {}

    def exportable(args, &block)
      raise 'You must specify a :as argument to name the export. Example: exportable :as => "foo"' if args[:as].nil?

      raise 'You must specify a :using argument to exportable. Example: exportable :using => :csv' if args[:using].nil? or !SUPPORTED_EXTENSIONS.key?(args[:using])

      @export_name = args[:as]
      @extension = SUPPORTED_EXTENSIONS[args[:using]]

      ::Array.send(:include, @extension)
      instance_eval(&block)

    end

    def columns(cols = nil)
      raise 'Columns can\'t be nil.' if cols.nil?
      @columns = cols
      
      eval "class ::Array; include #{@extension}; class << self; attr_accessor :#{@export_name.to_s}_columns; end; end"
      eval "class ::Array; def #{@export_name}; export('#{@export_name}'); end; end"
      ::Array.send("#{@export_name.to_s}_columns=", @columns)
    end

    def method_missing(method, *args, &block)
      @extension.send method, *args, &block
    end

  end
end
