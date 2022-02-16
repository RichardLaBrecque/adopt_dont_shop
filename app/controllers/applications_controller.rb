class ApplicationsController < ApplicationController

  def show
  @application = Application.find(params[:id])
    if params[:pet_name] != nil
      @pets = Pet.named(params[:pet_name])
      #binding.pry
    end

    #binding.pry
  end

  def new
  end

  def create
    application = Application.new(app_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  def update
    application = Application.find(params[:id])
    application.update(description: params[:description], status: "Pending")
    redirect_to "/applications/#{application.id}"
  end

  private

  def app_params
    params.permit(:id, :name, :street_address, :city, :zipcode, :description, :status)
  end
end
