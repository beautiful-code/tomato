class Restaurant < ActiveRecord::Base
  attr_accessible :address, :name, :phone, :zomato_url, :burrp_url, :yelp_url
  has_many :reviews
  has_many :notes
end
