class PetApplicationsController < ApplicationController
  def create
    petapplication = PetApplication.new(pet_app_params)
    petapplication.save
    redirect_to "/applications/#{pet_app_params[:application_id]}"
    #binding.pry
  end
private
  def pet_app_params
    params.permit(:pet_id, :application_id, :status)
  end
end
