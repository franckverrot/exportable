# acts_as_exportable

* http://github.com/cesario/exportable

## Description / Usage:

exportable is an easy way to export a collection using a predefined format.
Using an ORM (say ActiveRecord), one would do:
  # models/banana.rb
  class Banana
    # Attributes :size, :color

    # Export class method
    # Banana.export / Banana.export([1, 2, 4, 8])
    def self.export_as_csv(ids = nil)
      objs = ids.nil? where("id in (?)",ids) : all
      objs.each do |obj|
        obj.export_as_csv
      end
    end

    # Export instance method
    def export_as_csv
      # your logic here
    end
  end

  # controllers/banana_controller.rb
  ...
  Banana.export_as_csv([1,2,4,8])
  ...

... and this for each and every class, and for each and every export format.

With exportable, you will be handling pure Ruby objects and be able to share
the export format across multiple classes without any probme.

  # lib/simple_export.rb
  require 'exportable'
  module SimpleExport
    include Exportable
    
    exportable :as => :simple_export, :using => :csv do
      header    :column_names
      column_separator ';'
      row_separator '\n'

      columns :size  => "Size",
              :color  => "Color"
      end
    end
  end

  # models/banana.rb
  # Model left clean
  class Banana
    # Same attributes :size, :color
  end

  # controllers/some_controller.rb
  ...
  fruits = [ banana1, banana2, some_other_fruit_responding_to_size_and_color ]
  fruits.export(:simple_export)
  fruits.simple_export

The :as argument becomes an instance method of any Array object. You could either use myArray.export(:export_name_provided) or just myArray.export_name_provided

## Known issue

* Early release: Not fully featured yet!
* CSV extension: Internally, a Hash is used to store the list of columns to export.
With Ruby 1.8, the Hashes are not sorted, so you will have to rely on the header record which states the actual attribute order. With 1.9 and sorted Hashes, the order is respected.

## Requirements:

* Ruby 1.8.*
* None yet

## INSTALL:

* gem install exportable

