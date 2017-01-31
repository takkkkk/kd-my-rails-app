require 'nokogiri'
require 'open-uri'

class ArticleController < ApplicationController

  def index
    # @articles = Article.all
    # @article = Article.new

    doc = Nokogiri::HTML(open('http://www.ske48matoeme.com'))
    x = doc.xpath('//h2')

    # 記事のタイトルとURLを抜き出してDBにないものは保存する
    x.xpath('.//a').each do |title|
      @article = Article.new
      @article[:title] = title.inner_text
      @article[:url] = title[:href]
      i = 0
      @articles.each do |t|
        if t.url == @article[:url]
          i =+ 1
        end
      end

      if i==0
        @article.save
      end
    end

    @articles = Article.all

    # binding.pry

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
