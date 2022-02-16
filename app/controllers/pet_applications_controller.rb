class PetApplicationsController < ApplicationController
  def create
    petapplication = PetApplication.new(pet_app_params)
    petapplication.save
    redirect_to "/applications/#{pet_app_params[:application_id]}"
    #binding.pry
  end

  def update
    pet_app = PetApplication.find(params[:id])
    pet_app.update(pet_app_params)
    #binding.pry
    redirect_to "/admin/applications/#{pet_app.application_id}"
  end
private
  def pet_app_params
    params.permit(:pet_id, :application_id, :status)
  end
end
