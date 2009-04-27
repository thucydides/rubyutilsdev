#!ruby19
# encoding: utf-8


require 'search_source.rb'
require 'open-uri'
require 'iconv'
require 'htmlentities'

include SearchSource
#include Enumerable
#search term to test on intl. encodings
@sterm = "البحر"
puts @sterm


def inner_text(node)
  puts node.innerHTML
  text = node.innerHTML.gsub(%r{<.*?>}, "").strip
   HTMLEntities.new.decode(text)
end



results = Searcher.send :google, @sterm.to_s
words = []
results.each{|href|
  begin
  open(href) {|page|
    next if page.charset !~ /utf\-8/
    puts href + " : " + page.charset
    page.rewind
    #doc = Iconv.conv('utf-8', page.charset, page.readlines.join("\n"))
    doc = page.readlines.join("\n")
    puts "res"
    doc = Hpricot(doc)
    puts "After"
    (doc/"li").each{|node|
      inner_text(node).each_line{|line|
      puts line.encoding.name
      if line =~ /\p{Arabic}/
        puts line
        
      end
    }
    }
  }
  rescue
    puts $!
  end

}

