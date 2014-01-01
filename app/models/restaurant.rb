class Restaurant < ActiveRecord::Base
  attr_accessible :address, :name, :phone, :zomato_url, :burrp_url, :yelp_url
  has_many :reviews

  def collected_notes
    reviews.collect(&:consolidated_notes)
  end

  def uniq_items
    collected_notes.collect(&:keys).flatten
  end

  def uniq_items_dist
    uniq_items.inject(Hash.new(0)) { |total, e| total[e] += 1 ;total}
  end

  def clusters
    Util.cluster uniq_items_dist.keys
  end

  def cluster_label cluster
    label = cluster.first
    label_score = uniq_items_dist[label]
    cluster.each do |string|
      if uniq_items_dist[string] > label_score
        label = string 
        label_score = uniq_items_dist[string]
      end
    end
    label
  end

=begin
  def num_notes
    notes.count
  end

  def items
    notes.collect(&:item)
  end

  def items_dist
    items.inject(Hash.new(0)) { |total, e| total[e] += 1 ;total}
  end
=end
end
