class AdminController < ApplicationController
  def index
    @shelters = Shelter.find_by_sql("SELECT * FROM shelters ORDER BY name desc")
    @pending_shelters = Shelter.joins(pets: [pet_applications: :application]).where(applications: {status: "Pending"})
  end

  def show
    @application = Application.find(params[:id])
  end

end
