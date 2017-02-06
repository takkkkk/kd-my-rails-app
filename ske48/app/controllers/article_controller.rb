require 'nokogiri'
require 'open-uri'

class ArticleController < ApplicationController

  def index
    # @articles = Article.all
    # @article = Article.new

    doc = Nokogiri::HTML(open('http://www.ske48matoeme.com'))
    x = doc.xpath('//h2')
    @articles = Article.all
    @albums = Album.first

    # 記事のタイトルとURLを抜き出してDBにないものは保存する
    x.xpath('.//a').each do |title|
      @article = Article.new
      @article[:title] = title.inner_text
      @article[:url] = title[:href]

      @keyword = Array.new
      @keyword.push(@albums.keyword1)
      @keyword.push(@albums.keyword2)
      @keyword.push(@albums.keyword3)



      # 同じタイトルのものがあればiに1を足す
      i = 0
      @articles.each do |t|
        if t.url == @article[:url]
          i =+ 1
        end
      end



      # 同じ記事がなければ保存
      if i==0
        n = 0
        while n < 3 do
          if @article.title.include?(@keyword[n])
            @article.save
          end
          n += 1
        end
      end
    end
    @articles = Article.all.reverse
  end
end
