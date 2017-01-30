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
      puts title.inner_text
      puts title[:href]
    end
  end
end
