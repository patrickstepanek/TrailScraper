require 'nokogiri'
require 'open-uri'

states = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New-Hampshire", "New-Jersey", "New-Mexico", "New-York", "North-Carolina", "North-Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode-Island", "South-Carolina", "South-Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "Washington-dc", "West-Virginia", "Wisconsin", "Wyoming"]

c1 = 0; 

while c1<51

	puts "Compiling information for #{states[c1]}... #{c1*2}%"

	page = Nokogiri::HTML(open("https://www.alltrails.com/us/#{states[c1]}"))

	href = page.css('div.trail-result-card').map do |z|

		z.css("a").attr("href").value

	end;


    File.open("#{states[c1]}_trails.csv",'w+') do |i|

        i.puts ["trail","difficulty","location","overview","distance","elevation gain","route type","description","more"].join(',')
        	
    end;


	trail = Array.new

	c2 = 0;

	while true

		trail[c2] = Nokogiri::HTML(open("https://www.alltrails.com#{href[c2]}"))

		File.open("#{states[c1]}_trails.csv",'a+') do |k|

			trail[c2].css('body').map do |l|

				k.puts [ 

					l.css('h1').text.strip.gsub(/,/, ' '),
					l.css('div#difficulty-and-rating/span')[0].text.strip.gsub(/,/, ' '),
					l.css('h2').text.strip.gsub(/,/, ' '),
					l.css('section#trail-top-overview-text').text.strip.gsub(/,/, ' '),
					l.css('section#trail-stats/div/span/div.detail-data')[0].text.strip.gsub(/,/, ' '),
					l.css('section#trail-stats/div/span/div.detail-data')[1].text.strip.gsub(/,/, ' '),
					l.css('section#trail-stats/div/span/div.detail-data')[2].text.strip.gsub(/,/, ' '),
					l.css('div#trail-detail-item').text.strip.gsub(/,/, ' '),

				].join(',')

			end;

		end;

		c2+=1

	end;

	c1+=1

end;
