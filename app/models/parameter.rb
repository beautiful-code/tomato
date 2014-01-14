class Parameter < ActiveRecord::Base
  attr_accessible :feedback_id, :content

  belongs_to :feedback
  serialize :content, Hash
  validates_presence_of :feedback_id

  FEATURES = {
    "courtesy" => {
      "label" => "Courtesy of Staff",
      "values" => [["Rude", 1], ["Courteous/Friendly",5]],
      "category" => "service"
    },
    "queue_at_counter" => {
      "label" => "Queue at Counter",
      "values" => [["Long",1], ["Quick Moving",3], ["Short/No Queue",5]],
      "category" => "restaurant"
    },
    "wait_time_after_ordering" => {
      "label" => "Wait time after ordering",
      "values" => [["Long", 1], ["Short",5]],
      "category" => 'restaurant'
    },
    "price" => {
      "label" => "Price",
      "values" => [["Value", 5], ["Slightly Expensive",2], ["Very Expensive",1]],
      "category" => 'food'
    },
    "ambience" => {
      "label" => "Ambience",
      "values" => [["Disliked it",1], ["Liked it",5]],
      "category" => 'restaurant'
    },
    "parking" => {
      "label" => "Parking",
      "values" => [["Easy",5], ["Difficult",1]],
      "category" => "restaurant"
    },
    "menu_options" => {
      "label" => "Menu Options",
      "values" => [["Disliked it",1], ["Liked it",5]],
      "category" => "restaurant"
    },
    "meals" => {
      "label" => "Meals",
      "values" => [["Brunch",0], ["Breakfast",0], ["Lunch",0], ["Snack",0], ["Dinner",0]],
      "category" => "context"
    },
    "portions" => {
      "label" => "Portion size/Filling",
      "values" => [["Too large",5], ["Just enough",3], ["Too small",1] ],
      "category" => "food"
    },
    "user" => {
      "label" => "User",
      "values" => [["First time",0], ["Casual repeat",0], ["Regular",0]],
      "category" => "context"
    },
    "Company" => {
      "label" => "Company",
      "values" => [["Date",0], ["Family",0], ["Friends",0], ["Alone",0]],
      "category" => "context"
    },
    "healthy" => {
      "label" => "Healthy",
      "values" => [["No",1], ["Yes",5]],
      "category" => "food"
    },
    "served_hot" => {
      "label" => "Served Hot",
      "values" => [["No",1], ["Yes",5]],
      "category" => "food"
    },
    "attentiveness_of_staff" => {
      "label" => "Attentiveness of Staff",
      "values" => [["Not attentive",1], ["Attentive",5]],
      "category" => "service"
    },
    "hygene" => {
      "label" => "Hygene",
      "values" => [["Unhygenic",1], ["Hygenic",5]],
      "category" => "restaurant"
    },
    "found_us_through" => {
      "label" => "Found through",
      "values" => [["Yelp",0], ["Google",0], ["Family & Friends",0], ["Other",0]],
      "category" => "context"
    },
    "efficiency_of_staff" => {
      "label" => "Efficiency of Staff",
      "values" => [["Slow",1], ["Efficient",5]],
      "category" => "service"
    },
    "occasion" => {
      "label" => "Occasion",
      "values" => [["Birthday",0], ["Anniversary",0], ["Treat",0], ["Get-together",0]],
      "category" => "context"
    }

  }

  ['restaurant', 'service', 'food', 'context', 'extrensic'].each do |category|
    define_singleton_method "#{category}_features" do
      FEATURES.select {|k,v| v["category"] == category }
    end
  end

  FEATURES.each do |key, info|
    define_method key do
      self.content[key]
    end
  end

end
