class Parameter < ActiveRecord::Base
  attr_accessible :feedback_id, :content

  belongs_to :feedback
  serialize :content, Hash
  validates_presence_of :feedback_id

  FEATURES = {
    "courtesy" => {
      "label" => "Courtesy of Staff",
      "values" => ["Rude", "Courteous/Friendly"],
      "category" => "service"
    },
    "queue_at_counter" => {
      "label" => "Queue at Counter",
      "values" => ["Long", "Quick Moving", "Short/No Queue"],
      "category" => "restaurant"
    },
    "wait_time_after_ordering" => {
      "label" => "Wait time after ordering",
      "values" => ["Long", "Short"],
      "category" => 'restaurant'
    },
    "price" => {
      "label" => "Price",
      "values" => ["Value", "Slightly Expensive", "Very Expensive"],
      "category" => 'food'
    },
    "ambience" => {
      "label" => "Ambience",
      "values" => ["Disliked it", "Liked it"],
      "category" => 'restaurant'
    },
    "parking" => {
      "label" => "Parking",
      "values" => ["Easy", "Difficult"],
      "category" => "restaurant"
    },
    "menu_options" => {
      "label" => "Menu Options",
      "values" => ["Disliked it", "Liked it"],
      "category" => "restaurant"
    },
    "meals" => {
      "label" => "Meals",
      "values" => ["Brunch", "Breakfast", "Lunch", "Snack", "Dinner"],
      "category" => "context"
    },
    "portions" => {
      "label" => "Portion size/Filling",
      "values" => ["Too large", "too small", "just enough"],
      "category" => "food"
    },
    "user" => {
      "label" => "User",
      "values" => ["First time", "Casual repeat", "Regular"],
      "category" => "context"
    },
    "Company" => {
      "label" => "Company",
      "values" => ["Date", "Family", "Friends", "Alone"],
      "category" => "context"
    },
    "healthy" => {
      "label" => "Healthy",
      "values" => ["No", "Yes"],
      "category" => "food"
    },
    "served_hot" => {
      "label" => "Served Hot",
      "values" => ["No", "Yes"],
      "category" => "food"
    },
    "attentiveness_of_staff" => {
      "label" => "Attentiveness of Staff",
      "values" => ["Not attentive", "Attentive"],
      "category" => "service"
    },
    "hygene" => {
      "label" => "Hygene",
      "values" => ["Unhygenic", "Hygenic"],
      "category" => "restaurant"
    },
    "found_us_through" => {
      "label" => "Found through",
      "values" => ["Yelp", "Google", "Family & Friends", "Other"],
      "category" => "context"
    }
    "efficiency_of_staff" => {
      "label" => "Efficiency of Staff",
      "values" => ["Slow", "Efficient"],
      "category" => "service"
    }
    "occasion" => {
      "label" => "Occasion",
      "values" => ["Birthday", "Anniversary", "Treat", "Get-together"],
      "category" => "context"
    }

  }

  ['restaurant', 'service', 'food', 'context', 'extrensic'].each do |category|
    define_singleton_method "#{category}_features" do
      FEATURES.select {|k,v| v["category"] == category }
    end
  end

=begin
  def self.restaurant_features
    FEATURES.select {|k,v| v["category"] == "restaurant" }
  end
=end

  FEATURES.each do |key, info|
    define_method key do
      self.content[key]
    end
  end

end
