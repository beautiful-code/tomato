class Restaurant < ActiveRecord::Base
  attr_accessible :address, :name, :phone, :zomato_url, :burrp_url, :yelp_url
  has_many :reviews
  has_many :notes

  def num_notes
    notes.count
  end
end
