require 'rails_helper'
# Approving a Pet for Adoption
#
# As a visitor
# When I visit an admin application show page ('/admin/applications/:id')
# For every pet that the application is for, I see a button to approve the application for that specific pet
# When I click that button
# Then I'm taken back to the admin application show page
# And next to the pet that I approved, I do not see a button to approve this pet
# And instead I see an indicator next to the pet that they have been approved
RSpec.describe 'admin application show page' do
  it 'has an application show page' do
    @application = Application.create({name: "Person_1", street_address: "123 Fake St", city: "Fakecity", zipcode: "12345", description: " ", status: "Pending"})
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @shelter_3 = Shelter.create(name: 'Hollywood shelter', city: 'Irvine, CA', foster_program: false, rank: 7)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: @shelter_1.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter_1.id)
    @pet_3 = Pet.create(adoptable: true, age: 1, breed: 'domestic shorthair', name: 'Sylvester', shelter_id: @shelter_2.id)
    @pet_4 = Pet.create(adoptable: true, age: 1, breed: 'orange tabby shorthair', name: 'Lasagna', shelter_id: @shelter_3.id)
    @petapp = PetApplication.create!({pet_id: @pet_1.id, application_id: @application.id})
    visit "/admin/applications/#{@application.id}"
    expect(page).to have_content("Person_1's application Admin")
  end

  it 'can approve a pet application' do
    @application = Application.create({name: "Person_1", street_address: "123 Fake St", city: "Fakecity", zipcode: "12345", description: " ", status: "Pending"})
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @shelter_3 = Shelter.create(name: 'Hollywood shelter', city: 'Irvine, CA', foster_program: false, rank: 7)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: @shelter_1.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter_1.id)
    @pet_3 = Pet.create(adoptable: true, age: 1, breed: 'domestic shorthair', name: 'Sylvester', shelter_id: @shelter_2.id)
    @pet_4 = Pet.create(adoptable: true, age: 1, breed: 'orange tabby shorthair', name: 'Lasagna', shelter_id: @shelter_3.id)
    @petapp = PetApplication.create!({pet_id: @pet_1.id, application_id: @application.id})
    visit "/admin/applications/#{@application.id}"
    click_on "Approve #{@pet_1.name}"
    expect(current_path).to eq("/admin/applications/#{@application.id}")
    expect(page).to_not have_content("Approve #{@pet_1.name}")
    updated_app = PetApplication.find(@petapp.id)
    expect(updated_app.status).to eq("Approved")
    expect(page).to have_content("#{@pet_1.name}: #{updated_app.status}")
  end

  it 'can deny a pet application' do
    @application = Application.create({name: "Person_1", street_address: "123 Fake St", city: "Fakecity", zipcode: "12345", description: " ", status: "Pending"})
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @shelter_3 = Shelter.create(name: 'Hollywood shelter', city: 'Irvine, CA', foster_program: false, rank: 7)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: @shelter_1.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter_1.id)
    @pet_3 = Pet.create(adoptable: true, age: 1, breed: 'domestic shorthair', name: 'Sylvester', shelter_id: @shelter_2.id)
    @pet_4 = Pet.create(adoptable: true, age: 1, breed: 'orange tabby shorthair', name: 'Lasagna', shelter_id: @shelter_3.id)
    @petapp = PetApplication.create!({pet_id: @pet_1.id, application_id: @application.id})
    visit "/admin/applications/#{@application.id}"
    click_on "Deny #{@pet_1.name}"
    expect(current_path).to eq("/admin/applications/#{@application.id}")
    expect(page).to_not have_content("Deny #{@pet_1.name}")
    updated_app = PetApplication.find(@petapp.id)
    expect(updated_app.status).to eq("Denied")
    expect(page).to have_content("#{@pet_1.name}: #{updated_app.status}")
  end

  it 'can updating one pet_app  doesnt affect the same pet on a differnt app' do
    @application = Application.create({name: "Person_1", street_address: "123 Fake St", city: "Fakecity", zipcode: "12345", description: " ", status: "Pending"})
    @application_2 = Application.create({name: "Person_2", street_address: "123 Fake St", city: "Fakecity", zipcode: "12345", description: " ", status: "Pending"})
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @shelter_3 = Shelter.create(name: 'Hollywood shelter', city: 'Irvine, CA', foster_program: false, rank: 7)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: @shelter_1.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter_1.id)
    @pet_3 = Pet.create(adoptable: true, age: 1, breed: 'domestic shorthair', name: 'Sylvester', shelter_id: @shelter_2.id)
    @pet_4 = Pet.create(adoptable: true, age: 1, breed: 'orange tabby shorthair', name: 'Lasagna', shelter_id: @shelter_3.id)
    @petapp = PetApplication.create!({pet_id: @pet_1.id, application_id: @application.id})
    @petapp_2 = PetApplication.create!({pet_id: @pet_1.id, application_id: @application_2.id})
    visit "/admin/applications/#{@application.id}"
    click_on "Deny #{@pet_1.name}"
    expect(current_path).to eq("/admin/applications/#{@application.id}")
    expect(page).to_not have_content("Deny #{@pet_1.name}")
    updated_app = PetApplication.find(@petapp.id)
    updated_app_2 = PetApplication.find(@petapp_2.id)
    expect(updated_app.status).to eq("Denied")
    expect(updated_app_2.status).to eq("Pending")
    expect(page).to have_content("#{@pet_1.name}: #{updated_app.status}")
  end

end
