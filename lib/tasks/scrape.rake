desc "Scrape the Restaurant info & Reviews from Zomato"
namespace :zomato do
	desc "Scrape Restaurants information from Zomato"
	task :restaurants => :environment do
		require 'nokogiri'
  	require 'open-uri'
  	url = "http://www.zomato.com/hyderabad/restaurants"
		doc = Nokogiri::HTML(open(url))
		# Get the total number of pages listed with restaurant names
		pages = doc.at_css(".pagination-meta").text.split(' ').last.to_i 

		# 1.upto(pages) do |i|
		# 	url = "http://www.zomato.com/hyderabad/restaurants?page=#{i}"
		# 	doc = Nokogiri::HTML(open(url))
		# 	puts doc
		# end
		
	end

	desc "Scrape Reviews for each restaurant from Zomato"
	task :reviews => :environment do
		require 'nokogiri'
		require 'open-uri'
		require 'uri'
		require 'net/http'

		url = "http://www.zomato.com/hyderabad/barbeque-nation-banjara-hills/reviews"
		doc = Nokogiri::HTML(open(url))
		count = (doc.at_css(".selected .grey-text").text.strip.to_i)/5
		count = count - 1		
		# review_url = " curl -d 'entity_id=90038&profile_action=reviews-top&limit=58' http://www.zomato.com/php/social_load_more.php"
		
		uri = URI("http://www.zomato.com/php/social_load_more.php")
		http = Net::HTTP.new(uri.host, uri.port)
		request = Net::HTTP::Post.new(uri.path)

		request["entity_id"] = '90038'
		request["profile_action"] = 'reviews-top'
		request["limit"] = "#{count}"

		response = http.request(request)
		# puts response.body
		# puts doc.at_css(".res-main-name span").text.strip #Name
		# puts doc.at_css("#phoneNoString .alpha").text.strip #Phone
		# puts doc.at_css(".res-main-address-text").text.strip #Address
		@restaurant = Restaurant.first
		doc.css("p").each do |r|
			@review = @restaurant.reviews.build
			# puts r.text.strip
			@review.desc = r.text.strip
			@review.save
		end
	end
end

desc "Scrape Reviews from Burrp"
namespace :burrp do
	desc "Scrape Restaurant reviews from Burrp"
	task :reviews => :environment do
	require 'nokogiri'
	require 'open-uri'

	url = "http://hyderabad.burrp.com/listing/barbeque-nation_banjara-hills_hyderabad_restaurants/138686871__UR__reviews"
	doc = Nokogiri::HTML(open(url))
	count = (doc.at_css(".count").text[/[0-9]+/].to_i)/10
	
	1.upto(count) do |c|
		url = "http://hyderabad.burrp.com/listing/barbeque-nation_banjara-hills_hyderabad_restaurants/138686871__UR__reviews?page=#{c}"
		doc = Nokogiri::HTML(open(url))
		doc.css(".estab_reviewtext").each do |s|
			puts "Summary :"
			puts s.at_css(".summary").text.strip		
			puts "Description :"
			puts s.at_css(".float_r+ div , h3+ div span").text.strip
			puts "---------------------------------------"
		end
	end

	end
end

