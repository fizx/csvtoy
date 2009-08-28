require "rubygems"
require "fastercsv"

class CSVToy
  def initialize(options)
    @code = options[:code]
    @headers = options[:headers]
  end
  
  def rewrite(input, output)
    FasterCSV.filter(input, output, :headers => @headers) do |row|
      @code.each {|c| eval(c)}
    end
  end
end