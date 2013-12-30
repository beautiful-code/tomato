# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Restaurant.create(name: "Chutneys, Banjara Hills", zomato_url: "http://www.zomato.com/hyderabad/chutneys-banjara-hills/reviews", burrp_url: "http://hyderabad.burrp.com/listing/chutneys_banjara-hills_hyderabad_restaurants/121415188__UR__reviews") if !Restaurant.find_by_name('Chutneys, Banjara Hills').present?

Restaurant.create(name: "Indijoe, Banjara Hills", zomato_url: "http://www.zomato.com/hyderabad/indijoe-banjara-hills/reviews", burrp_url: "http://hyderabad.burrp.com/listing/indijoe_banjara-hills_hyderabad_restaurants/155472554__UR__reviews")
Restaurant.create(name: "Indijoe, Banjara Hills", zomato_url: "http://www.zomato.com/hyderabad/paradise-food-court-paradise-circle-secunderabad/reviews", burrp_url: "http://hyderabad.burrp.com/listing/paradise-food-court_s-d-road_secunderabad_restaurants/132416277__UR__reviews")
Restaurant.create(name: "Sahib Sindh Sultan, Banjara Hills", zomato_url: "http://www.zomato.com/hyderabad/sahib-sind-sultan-banjara-hills/reviews", burrp_url: "http://hyderabad.burrp.com/listing/sahib-sindh-sultan_banjara-hills_hyderabad_restaurants/187484722__UR__reviews")
