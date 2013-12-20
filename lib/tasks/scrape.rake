desc "Scrape the Restaurant info & Reviews from Zomato"
namespace :zomato do
	desc "Scrape Restaurants information from Zomato"
	task :restaurants => :environment do
	require 'nokogiri'
  	require 'open-uri'
        # url = "http://www.zomato.com/hyderabad/restaurants"
		# doc = Nokogiri::HTML(open(url))
		# # Get the total number of pages listed with restaurant names
		# pages = doc.at_css(".pagination-meta").text.split(' ').last.to_i 

		# 1.upto(pages) do |i|
		# 	url = "http://www.zomato.com/hyderabad/restaurants?page=#{i}"
		# 	doc = Nokogiri::HTML(open(url))
		# 	doc.css(".ln24.left a").each do |d|
		# 	   puts doc.at_css(".ln24.left a").text.strip
		# 	   puts doc.at_css("div.ln24 a").text.strip
		# 	   puts doc.at_css(".search-result-address").text.strip
		# 	end
		# end
	end

	desc "Scrape Reviews for each restaurant from Zomato"
	task :reviews => :environment do
		require 'nokogiri'
		require 'open-uri'

		@restaurants = Restaurant.all
		@restaurants.each do |restaurant|
			doc = Nokogiri::HTML(open(restaurant.zomato_url))
			restaurant.name = doc.at_css(".res-main-name span").text.strip 
			restaurant.phone = doc.at_css("#phoneNoString .alpha").text.strip 
			restaurant.address = doc.at_css(".res-main-address-text").text.strip 
			restaurant.save
			
			doc.css("#my-reviews-container .item-to-hide-parent").each do |a|
				@review = restaurant.reviews.build
				@review.title = "No Title for Zomato"
				@review.source = "Zomato"
				@review.author = a.at_css(".user-snippet-name").text.strip
				t =  a.at_css("time").text.split.first.to_i
				if t == 0
					time = 1.month.ago
				else
					time = t.months.ago
				end
				@review.review_created_at = time
				@review.desc = a.at_css("p").text.strip
				@review.save
			end
		end
	end
end

desc "Scrape Reviews from Burrp"
namespace :burrp do
	desc "Scrape Restaurant reviews from Burrp"
	task :reviews => :environment do
		require 'nokogiri'
		require 'open-uri'
		@restaurants = Restaurant.all
		@restaurants.each do |restaurant|
			doc = Nokogiri::HTML(open(restaurant.burrp_url))
		
			count = (doc.at_css(".count").text[/[0-9]+/].to_i)/10
		
			1.upto(count) do |c|
				url = "http://hyderabad.burrp.com/listing/barbeque-nation_banjara-hills_hyderabad_restaurants/138686871__UR__reviews?page=#{c}"
				doc = Nokogiri::HTML(open(url))
				doc.css(".estab_review").each do |s|
					@review = restaurant.reviews.build
					@review.title = s.at_css(".summary").text.strip	
					@review.source = "Burrp"
					@review.author = s.at_css(".reviewer").text.strip
					time = s.at_css(".float_r.grey").text.strip
					time = (Date.parse(time)).to_time
					@review.review_created_at = time
					@review.desc = s.at_css(".float_r+ div , h3+ div span").text.strip
				    @review.save
				end
			end
		end
	end
end







# count = (doc.at_css(".selected .grey-text").text.strip.to_i)/5
# count = count - 1		

# review_url = " curl -d 'entity_id=90038&profile_action=reviews-top&limit=#{count}' http://www.zomato.com/php/social_load_more.php"
# uri = URI("http://www.zomato.com/php/social_load_more.php")
# http = Net::HTTP.new(uri.host, uri.port)
# request = Net::HTTP::Post.new(uri.path)

# request["entity_id"] = '90038'
# request["profile_action"] = 'reviews-top'
# request["limit"] = "#{count}"

# response = http.request(request)
# puts response.body
