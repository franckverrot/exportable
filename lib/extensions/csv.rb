module ExportableExtensions
  module Csv
    SUPPORTED_HEADERS = [ :column_names, :none ]
    #Naive implementation of a CSV export
    #Better off with FasterCSV but that's for V1 :)
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def Csv.header header_type = :none
        if header_type and SUPPORTED_HEADERS.include?(header_type)
          @header_type = header_type
        else
          raise "invalid header symbol"
        end
      end

      def Csv.column_separator separator_string = ';'
        $column_separator ||= separator_string
      end

      def Csv.row_separator separator_string = '\n'
        $row_separator ||= separator_string
      end

    end


    def export(export_sym)
      return "" if ::Array.send("#{export_sym}_columns").nil?
      output = ""
      output << collect { |element|
        ::Array.send("#{export_sym}_columns").collect { |column_attr, column_friendlyname| 
          element.send("#{column_attr}") 
        }.join($column_separator)
      }.join($row_separator)
      output
    end
  end
end
