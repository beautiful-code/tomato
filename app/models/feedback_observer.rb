class FeedbackObserver < ActiveRecord::Observer
  observe :feedback

  def after_create(feedback)
    Parameter.create(:feedback_id => feedback.id, :content => {})
  end
end
