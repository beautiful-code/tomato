class ApplicationController < ActionController::Base
  protect_from_forgery


  def set_admin
    @admin = true
  end
end
