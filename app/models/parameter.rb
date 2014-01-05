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
  }

  FEATURES.each do |key, info|
    define_method key do
      self.content[key]
    end
  end

end
