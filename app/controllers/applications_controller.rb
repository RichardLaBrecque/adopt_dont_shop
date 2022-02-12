class ApplicationsController < ApplicationController
  def show
    @applicant = Application.find(params[:id])
  end

  def new
  end

  def create
    application = Application.new(app_params)
    application.save
    redirect_to "/applications/#{application.id}"
  end

  private

  def app_params
    params.permit(:id, :name, :street_address, :city, :zipcode, :description, :status)
  end
end
