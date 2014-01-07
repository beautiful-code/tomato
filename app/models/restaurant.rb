class Restaurant < ActiveRecord::Base
  attr_accessible :address, :name, :phone, :zomato_url, :burrp_url, :yelp_url
  has_many :reviews, :order => "id DESC"

  def collected_notes
    @collected_notes ||= reviews.collect(&:consolidated_notes)
  end

  def uniq_items
    collected_notes.collect(&:keys).flatten
  end

  def uniq_items_dist
    uniq_items.inject(Hash.new(0)) { |total, e| total[e] += 1 ;total}
  end

  def clusters
    @clusters ||= Util.cluster uniq_items_dist.keys
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

  def date_ordered_reviews
    reviews.order("review_created_at").group_by {|r| r.review_created_at.to_date}.to_a
  end

  def cluster_metrics cluster
    cluster_metrics = []

    date_ordered_reviews.each do |date ,reviews|
      puts date

      total_score = 0
      total_mentions = 0

      reviews.each do |review|
        notes = review.consolidated_notes
        cluster.each do |item|
          if notes[item]
            total_score += notes[item]
            total_mentions += 1
          end
        end
      end

      cluster_metrics << [date, {:total_score => total_score, :total_mentions => total_mentions}]

    end
    
    # cluster_metrics.map {|e| [e.first.to_time.to_i, e.second[:total_score]/e.second[:total_mentions]] }
    cluster_metrics.select {|e| e.second[:total_mentions] > 0}.map {|e| [e.first.to_time.to_i*1000, e.second[:total_score]/e.second[:total_mentions]] }
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
