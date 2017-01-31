class ArticleController < ApplicationController
  def index
    @articles = Article.all
  end

  def parseHTML 
    @articles = Article.new

    require 'nokogori'
    require 'open-uri'

    doc = Nokogiri::HTML(open('http://www.ske48matoeme.com'))
    x = doc.xpath('//h2')

    x.xpath('.//a').each do |title|
      @articles[:title] = title.inner_text
      @articles[:url] = title[:href]
    end


  end
end
