require 'rubygems'
require 'ruby-growl'

require 'mechanize'

	`touch /Users/grahamhadgraft/.nmeradionowplaying`

	nme_agent = Mechanize.new
	page = nme_agent.get "http://dx.nme.com/data.php"
	
	nowplaying = page.body

	
	page.body =~ /<artist>(.*?)<\/artist>/
	artist = $1
	page.body =~ /<title>(.*?)<\/title>/
	title=$1
	
@last_file = ''

File.open("/Users/grahamhadgraft/.nmeradionowplaying", "r") do |infile|
    while (line = infile.gets)
        @last_file += "#{line}"
    end
end



my_file = File.open("/Users/grahamhadgraft/.nmeradionowplaying", "w")  { |f| f.write "#{artist}\n#{title}" }

puts @last_file

if @last_file != "#{artist}\n#{title}" 
	g = Growl.new("localhost", "nmeradio", ["NME Radio"], ["NME Radio"], nil)
	g.notify("NME Radio", "NME Radio", "#{artist}\n#{title}", 1, false)
else
	
end