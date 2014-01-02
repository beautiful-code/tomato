class ApplicationController < ActionController::Base
  protect_from_forgery


  def set_admin
    @admin = true
  end

  def add_breadcrumb(name, url={})
    @breadcrumbs ||= []
    @breadcrumbs << [name,url]
  end
end
