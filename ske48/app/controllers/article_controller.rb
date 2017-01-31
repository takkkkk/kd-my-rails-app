require 'nokogiri'
require 'open-uri'

class ArticleController < ApplicationController

  def index
    @articles = Article.all
    @article = Article.new

    doc = Nokogiri::HTML(open('http://www.ske48matoeme.com'))
    x = doc.xpath('//h2')

    x.xpath('.//a').each do |title|
      @article[:title] = title.inner_text
      @article[:url] = title[:href]
    end

    binding.pry

    @article.save


  end

  def create
    @article = Article.new

    doc = Nokogiri::HTML(open('http://www.ske48matoeme.com'))
    x = doc.xpath('//h2')

    x.xpath('.//a').each do |title|
      @article[:title] = title.inner_text
      @article[:url] = title[:href]
    end

    @article.save
  end

  def new
    redirect_to article_create_path(@article)
  end

end
