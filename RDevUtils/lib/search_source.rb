#!ruby19
# encoding: utf-8
# To change this template, choose Tools | Templates
# and open the template in the editor.

module SearchSource
  require 'rubygems'
  require 'hpricot'


  class Searcher
   
    #returns a array of HREFs for processing by whatever you want give the search term
    def Searcher.google(sterm)
      s = URI::encode(sterm)
      results = []
      url = "http://www.google.com/search?num=5&q="
      open(url+s) {|page|
        txt = page.read
        hpr = Hpricot(txt)
        elems = hpr.search("#res h3.r a.l")
        elems.each {|atag|
          results << atag['href']
        }
      }
      return results
    end


  end


end
