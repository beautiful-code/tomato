class NotesController < ApplicationController
	# def index
	#  @restaurant = Restaurant.find(params[:restaurant_id])
 #    @review = @restaurant.reviews.find(params[:review_id])
 #    @notes = @review.notes
	# end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review =@restaurant.reviews.find(params[:note][:review_id])
    @note = @review.build_note
  end
  
  def edit
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review =@restaurant.reviews.find(params[:review_id])
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    if @note.update_attributes(params[:note])
      redirect_to yelp_restaurant_reviews_path, notice: 'Note was successfully Updated !'
    else
      render action: "edit" 
    end
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.find(params[:note][:review_id])
    @note = @review.build_note(params[:note])
    if @note.save
      redirect_to yelp_restaurant_reviews_path, notice: 'Note was successfully created.' 
    else
      render notice: 'Unsuccessful !'
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy

    flash[:notice] = "Successfully deleted the note."
    redirect_to yelp_restaurant_reviews_path
  end
end
