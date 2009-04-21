# To change this template, choose Tools | Templates
# and open the template in the editor.


require 'search_source.rb'
require 'open-uri'
include SearchSource

results = GoogleSource.search("السلام")
results.each{|href|
  open(href) {|page|
    text = page.read

    Hpricot(text).inner_text.each_line{|line|
      puts line if line =~ /سلام/
    }
  }

}