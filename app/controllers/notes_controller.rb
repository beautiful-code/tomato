class NotesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review =@restaurant.reviews.find(params[:review_id])
    @note = @review.notes.build
  end
  
  def edit
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.find(params[:review_id])
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    if @note.update_attributes(params[:note])
      redirect_to restaurant_review_path(params[:restaurant_id],params[:review_id]), notice: 'Note was successfully Updated !'
    else
      render action: 'edit'
    end
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.find(params[:review_id])

    @feedback = @review.get_feedback(current_user)
    @note = @feedback.notes.build(params[:note])
    if @note.save
      render :partial => 'feedbacks/notes', :locals => {:notes => @feedback.notes, :restaurant => @restaurant}
    else
      render notice: 'Unsuccessful !'
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.find(params[:review_id])
    @feedback = @review.get_feedback(current_user)
    @note = @feedback.notes.find(params[:id])
    @note.destroy

    redirect_to request.referrer
  end
end
