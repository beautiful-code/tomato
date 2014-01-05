class ParametersController < ApplicationController
  # GET /parameters
  # GET /parameters.json
  def index
    @parameters = Parameter.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @parameters }
    end
  end

  # GET /parameters/1
  # GET /parameters/1.json
  def show
    @parameter = Parameter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @parameter }
    end
  end

  # GET /parameters/new
  # GET /parameters/new.json
  def new
    @parameter = Parameter.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @parameter }
    end
  end

  # GET /parameters/1/edit
  def edit
    @parameter = Parameter.find(params[:id])
  end

  # POST /parameters
  # POST /parameters.json
  def create
    @parameter = Parameter.new(params[:parameter])

    respond_to do |format|
      if @parameter.save
        format.html { redirect_to @parameter, notice: 'Parameter was successfully created.' }
        format.json { render json: @parameter, status: :created, location: @parameter }
      else
        format.html { render action: "new" }
        format.json { render json: @parameter.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @parameter = Parameter.find(params[:id])

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
