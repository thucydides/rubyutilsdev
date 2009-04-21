# To change this template, choose Tools | Templates
# and open the template in the editor.

module SearchSource
  require 'rubygems'
  require 'hpricot'

  attr_accessor :surl

  def init(url)
    @surl = url
    puts @surl
  end

  class GoogleSource
    attr_accessor :gurl
    @gurl = "http://www.google.com/search?num=10&q="

    #returns a array of HREFs for processing by whatever you want give the search term
    def GoogleSource.search(sterm)
      s = URI::encode(sterm)
      results = []
      open(@gurl+s) {|page|
        hpr = Hpricot(page.read)
        (hpr/"#res h3.r a.l").each {|atag|
          puts atag.inner_text
          results << atag['href']
        }
      }
      return results
    end


  end


end
