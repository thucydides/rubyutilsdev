#!ruby19
# encoding: utf-8


require 'search_source.rb'
require 'open-uri'
require 'iconv'

include SearchSource

def get_arabic_words(sterm= "البحر", lang=/\p{Arabic}/)
  results = Searcher.send :google, sterm
  results.each{|href|
    begin
    open(href) {|page|
      next if page.charset !~ /utf\-8/
      htm = page.read.encode("utf-8")
      doc = Hpricot(htm)
      (doc/"a").each{|node|
        inn = node.inner_text
        #for some reason, the encoding coming out of inner_text of the text is not labeled as UTF8 by the encompassed Encoding object
        #so we have to change that by forcing the encoding
        inn.force_encoding("utf-8")
        if inn =~ lang
          puts inn
        end
      }
    }
    rescue
      puts "error~"
      puts $!
    end
    }
end


get_arabic_words


