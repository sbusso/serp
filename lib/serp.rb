# require "serp/version"
require 'nokogiri'
require 'mechanize'
require 'open-uri'

module Serp

  
  def self.search_engine=(val)
    @@search_engine = val
  end

  def self.search_engine
    @@search_engine || "http://www.google.com"
  end

  def self.rank(keywords, locale = 'en' , pages = 3)
    results = []
    agent = Mechanize.new
    page = agent.get("#{search_engine}?hl=#{locale}")
    google_form = page.form('f')
    google_form.q = keywords
    page = agent.submit(google_form, google_form.buttons.first)
    (1..pages).each do |pn|
      (page/"li.g h3.r > a").each do |link|
        href = link.attribute('href').value
        results << parse_href(link.attribute('href').value) if href =~ /^\/url/ && !(href =~ /plus.google.com/)
      end
      page = page.link_with(:text => "#{pn+1}", :class => 'fl').click if pn < pages
    end

    return results
  end

  private

  def self.parse_href(href)
    URI.parse(href.scan(/(https?:\/\/.*)\//).flatten.last).host.gsub('www.', '')
  end
end
