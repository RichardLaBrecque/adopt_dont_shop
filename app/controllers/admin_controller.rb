class AdminController < ApplicationController
  def index
    @shelters = Shelter.descending_names
    @pending_shelters = Shelter.pending
  end

  def show
    @application = Application.find(params[:id])
  end

end
