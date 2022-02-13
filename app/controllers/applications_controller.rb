class ApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end
  def show
    @applicant = Application.find(params[:id])
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

  private

  def app_params
    params.permit(:id, :name, :street_address, :city, :zipcode, :description, :status)
  end
end
