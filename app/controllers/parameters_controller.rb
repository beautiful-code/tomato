class ParametersController < ApplicationController
  before_filter :authenticate_user!

  def update
    @feedback = current_user.feedbacks.find(params[:feedback_id])
    @parameter = @feedback.parameter

    if @parameter.update_attribute(:content, params[:parameter])
      redirect_to request.referer, notice: 'Parameters was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @parameter = Parameter.find(params[:id])
    @parameter.destroy

    respond_to do |format|
      format.html { redirect_to parameters_url }
      format.json { head :no_content }
    end
  end
end
