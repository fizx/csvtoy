require 'optparse'

class CSVToyOptionParser < OptionParser
  attr_accessor :options
  
  def usage
    "\n  Usage: cat in.csv | #{$0} [options] > out.csv\n\n"+
    "  Ruby code is evaled in the block: \n" + 
    "  in_csv.rows.each {|row| out_csv << eval(your_code) }\n\n"
  end
  
  def parse!
    options[:headers] = true
    options[:code]    = []
    super.parse!
  end
  
  def initialize
    self.options = {}
    super do |opts|
      
      yield opts if block_given?
  
      opts.banner = usage
  
      opts.on("-r", "--require LIB", "require 'LIB'") do |lib|
        require lib
      end
      
      opts.on("-h", "--headers", "First row is headers [default]") do |lib|
        options[:headers] = true
      end
      
      opts.on("-H", "--no-headers", "First row is NOT headers") do |lib|
        options[:headers] = false
      end
  
      opts.on("-e", "--eval=CODE", "eval a string of Ruby code") do |e|
        options[:code] << e
      end

      opts.on("-f", "--file=CODE", "eval a file of Ruby code") do |f|
        options[:code] << File.read(f)
      end
    end
  end
end