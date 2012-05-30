# require "serp/version"
require 'nokogiri'
require 'mechanize'
require 'open-uri'

module Serp
  def self.rank(keywords, pages = 3)
    results = []
    agent = Mechanize.new
    page = agent.get("http://www.google.com?hl=en")
    google_form = page.form('f')
    google_form.q = keywords
    page = agent.submit(google_form, google_form.buttons.first)
    (1..pages).each do |pn|
      (page/"li.g h3.r a").each do |link|
        results << parse_href(link.attribute('href').value) if link.attribute('href').value =~ /^\/url/
      end
      page = page.link_with(:text => "#{pn+1}", :class => 'fl').click if pn < pages
    end

    return results
  end

  private

  def self.parse_href(href)
    URI.parse(href.scan(/(http:\/\/.*)\//).flatten.last).host.gsub('www.', '')

  end
end