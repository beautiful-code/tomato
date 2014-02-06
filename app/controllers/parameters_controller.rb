class ParametersController < ApplicationController
  before_filter :authenticate_user!

  def update
    @feedback = current_user.feedbacks.find(params[:feedback_id])
    @parameter = @feedback.parameter
    parameters = construct_parameters params
    if @parameter.update_attribute(:content, parameters)
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

  private

  # Construct params like so {:queue_at_counter=>{:value=>'Long',:why=>'some reason'}, :ambience=>{:value=>'good',:why=>'some reason'} }
  def construct_parameters params
    params = params[:parameter].select{|k,v| v.present?}
    why_params = par.select {|k,v|  k.include? "_why" }
    params.reject! {|k,v|  k.include? "_why" }
    pa = {}
    par.each {|k,v| why_params.each{|k1,v1| k1.include?(k) ? (pa[k]={:value=>v,:why=>v1} ) : (nil) } }
    pa
  end
end
