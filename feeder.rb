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

def watching(title)
    watching = false
    if /HorribleSubs/ =~ title and /\[1080p\]/ =~ title
        if /Sakamichi no Apollon/ =~ title
            watching = true
        elsif /Tsuritama/ =~ title
            watching = true
        elsif /Sengoku Collection/ =~ title
            watching = true
        elsif /Haiyore! Nyaruko-san/ =~ title
            watching = true
        end
    elsif /\[Mazui\]/ =~ title and /Hyouka/ =~ title
        watching = true
    elsif /\[EveTaku\]/ =~ title and /AKB0048/ =~ title
        watching = true
    elsif /\[UTW\]/ =~ title and /Accel_World/ =~ title
        watching = true
    elsif /\[UTW\]/ =~ title and /Fate_Zero/ =~ title
        watching = true
    elsif /\[gg\]/ =~ title and /Jormungand/ =~ title
        watching = true
    end
    return watching
end 

def parse_item(item)
    title = item.xpath("//title").text
    if watching(title)
        puts "<item>"
        puts item.xpath("//title")
        puts item.xpath("//url")
        puts "</item>" 
    end

end

feed = open_feed("http://tokyotosho.info/rss.php?filter=1")

items = feed.xpath("//item")

puts "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"


items.each do |item|
    parse_item(Nokogiri::XML(item.to_s))
end

