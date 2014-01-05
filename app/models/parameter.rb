class Parameter < ActiveRecord::Base
  attr_accessible :feedback_id, :content

  belongs_to :feedback
  serialize :content, Hash
  validates_presence_of :feedback_id

  FEATURES = {
    "courtesy" => {
      "label" => "Courtesy of Staff",
      "values" => ["Rude", "Neutral", "Courteous/Friendly"]
    },
    "queue_at_counter" => {
      "label" => "Queue at Counter",
      "values" => ["Long", "Quick Moving", "Short/No Queue"]
    }
  }

  FEATURES.each do |key, info|
    define_method key do
      self.content[key]
    end
  end

end
