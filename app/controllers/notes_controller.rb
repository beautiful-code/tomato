class NotesController < ApplicationController

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
      redirect_to restaurant_review_path(params[:restaurant_id],params[:review_id]), notice: 'Note was successfully Updated !'
    else
      render action: 'edit'
    end
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.find(params[:review_id])
    @note = @review.notes.build(params[:note])
    if @note.save
      redirect_to restaurant_review_path(params[:restaurant_id],params[:review_id]), notice: 'Note was successfully created.'
    else
      render notice: 'Unsuccessful !'
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy

    redirect_to restaurant_review_path(params[:restaurant_id],params[:review_id]), notice: 'Successfully deleted the note.'
  end
end
