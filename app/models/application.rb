class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def create
    application = Application.new({name: "applicant_1", street_address: "123 fake", city: "Fakecity", zipcode: "12345", description: "cus dogs", status: "pending" })
    application.save
  end
end
