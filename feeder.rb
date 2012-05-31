require 'nokogiri'
require 'open-uri'

# feed = Nokogiri::HTML(open("http://tokyotosho.info/rss.php?filter=1"))

def open_feed(url)
    feed = open("http://tokyotosho.info/rss.php?filter=1").read
    feed = feed.gsub(/<link>/, "<url>")
    feed = feed.gsub(/<\/link>/, "</url>")
    feed = feed.gsub(/\]\]>/, "")
    feed = feed.gsub(/<!\[CDATA\[/, "")
    Nokogiri::HTML(feed)
end

def parse_item(item)
    puts "<item>"
    puts item.xpath("//title")
    puts item.xpath("//url")
    puts "</item>" 
end

feed = open_feed("http://tokyotosho.info/rss.php?filter=1")

items = feed.xpath("//item")

items.each do |item|
    parse_item(Nokogiri::XML(item.to_s))
end

