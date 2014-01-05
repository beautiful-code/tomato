class Parameter < ActiveRecord::Base
  attr_accessible :feedback_id, :content

  belongs_to :feedback
  serialize :content, Hash
  validates_presence_of :feedback_id

  FEATURES = {
    "courtesy" => {
      "label" => "Courtesy of Staff",
      "values" => ["Rude", "Neutral", "Courteous/Friendly"],
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
      "values" => ["Value for money", "Slightly Expensive", "Very Expensive"],
      "category" => 'food'
    },
    "ambience" => {
      "label" => "Ambience",
      "values" => ["Disliked it", "Liked it", "Loved it"],
      "category" => 'restaurant'
    },
    "parking" => {
      "label" => "Parking",
      "values" => ["Easy", "Difficult"],
      "category" => "restaurant"
    },
    "menu_options" => {
      "label" => "Menu Options",
      "values" => ["Disliked it", "Liked id", "Loved it"],
      "category" => "restaurant"
    },
    "meals" => {
      "label" => "Menu Options",
      "values" => ["Brunch", "Breakfast", "Lunch", "Snack", "Dinner"],
      "category" => "context"
    },
    "portions" => {
      "label" => "Portion size/Filling",
      "values" => ["Too large", "too small", "just enough"],
      "category" => "food"
    },
    "noise" => {
      "label" => "Noise",
      "values" => ["Disliked it", "Liked id", "Loved it"],
      "category" => "restaurant"
    },
    "user" => {
      "label" => "User",
      "values" => ["First time", "Casual repeat", "Regular"],
      "category" => "context"
    },
    "occasion" => {
      "label" => "Occasion",
      "values" => ["Date", "Family", "Friends", "Alone", "Unplanned"],
      "category" => "context"
    },
    "healthy" => {
      "label" => "Healthy",
      "values" => ["Unhealthy", "Healthy"],
      "category" => "food"
    },
    "attentiveness_of_staff" => {
      "label" => "Attentiveness of Staff",
      "values" => ["Not attentive", "Attentive"],
      "category" => "service"
    },
    "time_to_drive" => {
      "label" => "Time taken to drive to restaurant",
      "values" => ["Short", "Long"],
      "category" => "extrensic"
    },
    "hygene" => {
      "label" => "Hygene",
      "values" => ["Unhygenic", "Hygenic"],
      "category" => "restaurant"
    },
    "free_items" => {
      "label" => "Free Items",
      "values" => ["No", "Yes"],
      "category" => "restaurant"
    },
    "complementary_available" => {
      "label" => "Availability of complementary products",
      "values" => ["No", "Yes"],
      "category" => "extrensic"
    },
    "nearby_places_influence" => {
      "label" => "Nearby places influence",
      "values" => ["No", "Yes"],
      "category" => "extrensic"
    },

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
