class Restaurant < ActiveRecord::Base
  attr_accessible :address, :name, :phone, :zomato_url, :burrp_url, :yelp_url
  has_many :reviews
  has_many :notes, :through => :reviews

  def num_notes
    notes.count
  end

  def items
    notes.collect(&:item)
  end

  def items_dist
    items.inject(Hash.new(0)) { |total, e| total[e] += 1 ;total}
  end
end
