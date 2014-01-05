class UserController < ApplicationController
  before_filter :authenticate_user!
  
  def feedbacks
    @reviews = current_user.reviews
  end
end
