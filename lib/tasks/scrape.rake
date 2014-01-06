desc "Scrape the Restaurant info & Reviews from Zomato"
namespace :zomato do

  desc "Scrape Reviews for each restaurant from Zomato"
  task :reviews => :environment do
    require 'nokogiri'
    require 'open-uri'

    @restaurants = Restaurant.all
    @restaurants.each do |restaurant|
      restaurant.last_fetched_at||= 2.days.ago
      if !restaurant.zomato_url.blank?
        #if restaurant.last_fetched_at < 1.day.ago
        if true
          doc = Nokogiri::HTML(open(restaurant.zomato_url))
          restaurant.name = doc.at_css(".res-main-name span").text.strip
          restaurant.phone = doc.at_css("#phoneNoString .alpha").text.strip
          restaurant.address = doc.at_css(".res-main-address-text").text.strip

          puts "Fetching reviews for #{restaurant.name}"
          doc.css("#my-reviews-container .item-to-hide-parent").each do |a|
            begin
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
              @review.rating = a.at_css(".small-rating").text.strip.to_f
              @review.review_created_at = time
              @review.desc = a.at_css("p").to_s
              @review.save
            rescue
              next
            end
          end
          restaurant.last_fetched_at = Time.now
          restaurant.save
        else
          puts "Reviews are fetched recently for the restaurant #{restaurant.name} !"
        end
      else
        puts "This Restaurant : #{restaurant.name} is not listed on Zomato"
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
      restaurant.last_fetched_at||= 2.days.ago
      if !restaurant.burrp_url.blank?
        if restaurant.last_fetched_at < 1.day.ago
          doc = Nokogiri::HTML(open(restaurant.burrp_url))
          num_reviews = doc.at_css(".count").text[/[0-9]+/].to_i

          puts "Fetching reviews (#{num_reviews}) for #{restaurant.name}"
          num_pages = (num_reviews)/10

          count = 0

          1.upto(num_pages) do |c|
            url = "#{restaurant.burrp_url}?page=#{c}"
            doc = Nokogiri::HTML(open(url))
            doc.css(".estab_review").each do |s|
              begin
                @review = restaurant.reviews.build
                @review.title = s.at_css(".summary").text.strip
                @review.source = "Burrp"
                @review.author = s.at_css(".reviewer").text.strip
                time = s.at_css(".float_r.grey").text.strip
                time = (Date.parse(time)).to_time
                @review.review_created_at = time
                @review.rating = s.css(".smallRating span")[0]['title']
                @review.desc = s.at_css(".float_r+ div , h3+ div span").to_s
                @review.save
                count +=1
              rescue
                next
              end
            end
          end
          restaurant.last_fetched_at = Time.now
          restaurant.save
          puts "#{count} reviews fetched out of #{num_reviews} !"
        else
          puts "Reviews are fetched recently for the restaurant #{restaurant.name} !"
        end
      else
        puts "This Restaurant : #{restaurant.name} is not listed on Burrp"
      end
    end
  end
end

desc "Scrape Reviews from Yelp"
namespace :yelp do
  desc "Scrape Restaurant reviews from Burrp"
  task :reviews => :environment do
    require 'nokogiri'
    require 'open-uri'

    Rails.logger.info

    @restaurants = Restaurant.all
    @restaurants.each do |restaurant|
      restaurant.last_fetched_at||= 2.days.ago
      if !restaurant.yelp_url.blank?
        if restaurant.last_fetched_at < 1.day.ago
          doc = Nokogiri::HTML(open(restaurant.yelp_url, "User-Agent" => "Ruby/ruby-1.9.3-p327"))

          restaurant.address = doc.css("address").text.strip
          restaurant.phone = doc.css("#bizPhone").text.strip

          rcount = doc.css(".reviews-header").text[/[0-9]+/].to_i
          puts "Fetching (#{rcount}) reviews for #{restaurant.name}"

          count = 0

          (0..rcount).step(40) do |page|
            url = "#{restaurant.yelp_url}?start=#{page}"
            doc = Nokogiri::HTML(open(url, "User-Agent" => "Ruby/ruby-1.9.3-p327"))
            doc.css(".review").each do |r|
              @review = restaurant.reviews.build
              @review.title = "Not available"
              @review.source = "Yelp"
              @review.author = r.css(".user-name a").text.strip
              @review.review_created_at= r.css(".review-meta .date.smaller").text.strip
              begin
                @review.rating = r.css(".rating meta")[0]["content"].to_f
              rescue
                @review.rating = -1
              ensure
                @review.desc = r.css(".media-story p.review_comment").to_s
                if (@review.desc).blank?
                  break
                else
                  if Review.find_by_desc(@review.desc).nil?
                    @review.save
                    count +=1
                  end
                end
              end
            end
          end
          restaurant.last_fetched_at = Time.now
          restaurant.save
          puts "#{count} reviews fetched out of #{rcount} !"
        else
        	puts "Reviews are fetched recently for the restaurant #{restaurant.name} !"
        end
      else
        puts "This Restaurant : #{restaurant.name} is not listed on Yelp"
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
