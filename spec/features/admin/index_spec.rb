require 'rails_helper'
# SQL Only Story
#
# For this story, you should write your queries in raw sql.
# You can use the ActiveRecord find_by_sql method to
# execute raw sql queries
# Admin Shelters Index
# As a visitor
# When I visit the admin shelter index ('/admin/shelters')
# Then I see all Shelters in the system listed in
# reverse alphabetical order by name

RSpec.describe 'Admin Index' do
  describe 'shelter index' do
    before(:each) do
      @application = Application.create({name: "Person_1", street_address: "123 Fake St", city: "Fakecity", zipcode: "12345", description: " ", status: "Pending"})
      @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @shelter_2 = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      @shelter_3 = Shelter.create(name: 'Hollywood shelter', city: 'Irvine, CA', foster_program: false, rank: 7)
      @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: @shelter_1.id)
      @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter_1.id)
      @pet_3 = Pet.create(adoptable: true, age: 1, breed: 'domestic shorthair', name: 'Sylvester', shelter_id: @shelter_2.id)
      @pet_4 = Pet.create(adoptable: true, age: 1, breed: 'orange tabby shorthair', name: 'Lasagna', shelter_id: @shelter_3.id)
      @petapp = PetApplication.create!({pet_id: @pet_1.id, application_id: @application.id})
    end
    it 'has an admin shelters index page' do
      visit '/admin/shelters'
    end

    it 'lists shelters in reverse alphabetical order' do
      visit '/admin/shelters'
      expect(@shelter_2.name).to appear_before(@shelter_3.name)
      expect(@shelter_3.name).to appear_before(@shelter_1.name)
    end
    # Shelters with Pending Applications
    # As a visitor
    # When I visit the admin shelter index ('/admin/shelters')
    # Then I see a section for "Shelter's with Pending Applications"
    # And in this section I see the name of every shelter that has a pending application
    it 'has a section with shelters with pending applications' do
      visit '/admin/shelters'
      within ".pending-app" do

        expect(page).to have_content("Shelters with pending applications")
        expect(page).to have_content(@shelter_1.name)
        expect(page).to_not have_content(@shelter_3.name)
      end
    end
  end
end
