class Admin::NotesController < ApplicationController
  before_filter :authenticate_user!
  # def index
  #  @restaurant = Restaurant.find(params[:restaurant_id])
  #    @review = @restaurant.reviews.find(params[:review_id])
  #    @notes = @review.notes
  # end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review =@restaurant.reviews.find(params[:review_id])
    @note = @review.notes.build
  end

  def edit
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review =@restaurant.reviews.find(params[:review_id])
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    if @note.update_attributes(params[:note])
      redirect_to admin_restaurant_review_path(params[:restaurant_id],params[:review_id]), notice: 'Note was successfully Updated !'
    else
      render action: 'edit'
    end
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.find(params[:review_id])
    params[:note][:user_id] = current_user.id
    @note = @review.notes.build(params[:note])
    if @note.save
      render :partial => 'admin/reviews/notes', :locals => {:notes => @review.get_notes(current_user)}
    else
      render notice: 'Unsuccessful !'
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @review = Review.find(params[:review_id])
    @restaurant = Restaurant.find(params[:restaurant_id])
    @note.destroy
    render :partial => 'admin/reviews/notes', :locals => {:notes => @review.get_notes(current_user)}
  end
end
