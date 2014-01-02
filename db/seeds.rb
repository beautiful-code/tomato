# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Restaurant.create(name: "Chutneys, Banjara Hills", zomato_url: "http://www.zomato.com/hyderabad/chutneys-banjara-hills/user_notes", burrp_url: "http://hyderabad.burrp.com/listing/chutneys_banjara-hills_hyderabad_restaurants/121415188__UR__reviews") if !Restaurant.find_by_name('Chutneys, Banjara Hills').present?
Restaurant.create(name: "Indijoe, Banjara Hills", zomato_url: "http://www.zomato.com/hyderabad/indijoe-banjara-hills/user_notes", burrp_url: "http://hyderabad.burrp.com/listing/indijoe_banjara-hills_hyderabad_restaurants/155472554__UR__reviews") if !Restaurant.find_by_name('Indijoe, Banjara Hills').present?
Restaurant.create(name: "Paradise Food Court, Secunderabad", zomato_url: "http://www.zomato.com/hyderabad/paradise-food-court-paradise-circle-secunderabad/user_notes", burrp_url: "http://hyderabad.burrp.com/listing/paradise-food-court_s-d-road_secunderabad_restaurants/132416277__UR__reviews") if !Restaurant.find_by_name('Paradise Food Court, Secunderabad').present?
Restaurant.create(name: "Sahib Sindh Sultan, Banjara Hills", zomato_url: "http://www.zomato.com/hyderabad/sahib-sind-sultan-banjara-hills/user_notes", burrp_url: "http://hyderabad.burrp.com/listing/sahib-sindh-sultan_banjara-hills_hyderabad_restaurants/187484722__UR__reviews") if !Restaurant.find_by_name('Sahib Sindh Sultan, Banjara Hills').present?
Restaurant.create(name: "Porto's Bakery", yelp_url: "http://www.yelp.com/biz/portos-bakery-glendale") if !Restaurant.find_by_name("Porto's Bakery").present?
Restaurant.create(name: "Raffis Place", yelp_url: "http://www.yelp.com/biz/raffis-place-glendale-2") if !Restaurant.find_by_name("Raffis Place").present?
Restaurant.create(name: "Skaf's Lebanese Cuisine", yelp_url: "http://www.yelp.com/biz/skafs-lebanese-cuisine-glendale") if !Restaurant.find_by_name("Skaf's Lebanese Cuisine").present?
Restaurant.create(name: "Mario's Italian Deli & Market", yelp_url: "http://www.yelp.com/biz/marios-italian-deli-and-market-glendale") if !Restaurant.find_by_name("Mario's Italian Deli & Market").present?
Restaurant.create(name: "Eden Burger Bar", yelp_url: "http://www.yelp.com/biz/eden-burger-bar-glendale") if !Restaurant.find_by_name("Eden Burger Bar").present?
Restaurant.create(name: "Foxy's Restaurant", yelp_url: "http://www.yelp.com/biz/foxys-restaurant-glendale-3") if !Restaurant.find_by_name("Foxy's Restaurant").present?
