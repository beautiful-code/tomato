class Admin::NotesController < ApplicationController
  before_filter :set_admin
  before_filter :authenticate_user!

  def destroy
    @note = Note.find(params[:id])
    @review = Review.find(params[:review_id])
    @restaurant = Restaurant.find(params[:restaurant_id])
    @note.destroy

    redirect_to request.referrer
  end
end
