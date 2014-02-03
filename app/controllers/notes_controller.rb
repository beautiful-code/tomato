class NotesController < ApplicationController
  before_filter :authenticate_user!

  def update
    @note = Note.find(params[:id])
    if @note.update_attributes(params[:note])
      redirect_to restaurant_review_path(params[:restaurant_id],params[:review_id]), notice: 'Note was successfully Updated !'
    else
      render action: 'edit'
    end
  end

  def create
    @feedback = current_user.feedbacks.find(params[:feedback_id])
    @note = @feedback.notes.build(params[:note])
    if @note.save
      render :partial => 'notes/list', :locals => {:notes => @feedback.notes, :restaurant => @restaurant}
    else
      render notice: 'Unsuccessful !'
    end
  end

  def destroy
    @feedback = current_user.feedbacks.find(params[:feedback_id])
    @note = @feedback.notes.find(params[:id])
    @note.destroy

    redirect_to request.referrer
  end
end
