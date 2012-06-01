require 'nokogiri'
require 'open-uri'

def open_feed(url)
    feed = open(url).read
    feed = feed.gsub(/<link>/, "<url>")
    feed = feed.gsub(/<\/link>/, "</url>")
    feed = feed.gsub(/\]\]>/, "")
    feed = feed.gsub(/<!\[CDATA\[/, "")
    Nokogiri::HTML(feed)
end

def watching(title)
    watching = false
    if /\[HorribleSubs\]/ =~ title and /\[1080p\]/ =~ title
        if /Sakamichi no Apollon/ =~ title
            watching = true
        elsif /Tsuritama/ =~ title
            watching = true
        elsif /Sengoku Collection/ =~ title
            watching = true
        elsif /Haiyore! Nyaruko-san/ =~ title
            watching = true
        end
    elsif /\[Over-Time\]/ =~ title and /Akibaranger/ =~ title and /SD/ !~ title
        watching = true
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
    url = item.xpath("//url").text
    if watching(title)
        puts "<item>"
        puts "<title>#{title}</title>"
        puts "<link>#{url}</link>"
        puts "</item>" 
    end

end

def begin_feed()
    puts "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
    puts "<rss version=\"2.0\" xmlns:atom=\"http://www.w3.org/2005/Atom\">"
    puts "<channel><atom:link href=\"http://tokyotosho.info/rss.php\" rel=\"self\" type=\"application/rss+xml\" />"
    puts "<title>Haruchin sugoi! =w=</title>"
    puts
end

def print_feed(url)
    feed = open_feed(url)

    items = feed.xpath("//item")

    items.each do |item|
        parse_item(Nokogiri::XML(item.to_s))
    end
end

begin_feed()
print_feed("http://tokyotosho.info/rss.php?filter=1")
print_feed("http://tokyotosho.info/rss.php?filter=8")
