require File.dirname(__FILE__) + '/spec_helper.rb'

describe "The exportable library" do
  before(:each) do
    module SimpleExport
      include Exportable
    end
  end

  it "has a CSV export" do
    SimpleExport
  end

  describe "CSV extension" do
    before(:each) do
      module SimpleExport
        include Exportable
        #exportable :as => :simple_export do
        #  header    :column_names
        #  column_separator ';'
        #  row_separator '\n'

        #  columns :firstname  => "First name",
        #    :lastname  => "Last name",
        #    :email  => "Email"
        #end
      end
    end

    describe "is configurable" do
      it "and can be named" do
        module SimpleExport
          exportable :as => "simple_export", :using => :csv do
          end
        end
      end

      it "using a header" do
        module SimpleExport
          exportable :as => "simple_export", :using => :csv do
            header :column_names
          end
        end
      end

      it "using a column separator" do
        module SimpleExport
          exportable :as => "simple_export", :using => :csv do
            column_separator 'row_separator'
          end
        end
      end

      it "using a row separator" do
        module SimpleExport
          exportable :as => "simple_export", :using => :csv do
            row_separator 'row_separator'
          end
        end
      end
    end

    it "can be set to export specific columns" do
      module SimpleExport
        exportable :as => "simple_export", :using => :csv  do
          columns :email => "foo", :firstname => "bar"
        end
      end
      p ExportableTests.dataset
      p ExportableTests.dataset.export(:simple_export)
    end
  end
end
