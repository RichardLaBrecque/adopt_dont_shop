require 'rails_helper'
# [ ] done
#
# Starting an Application
#
# As a visitor
# When I visit the pet index page
# Then I see a link to "Start an Application"
# When I click this link
# Then I am taken to the new application page where I see a form
# When I fill in this form with my:
#   - Name
#   - Street Address
#   - City
#   - State
#   - Zip Code
# And I click submit
# Then I am taken to the new application's show page
# And I see my Name, address information, and description of why I would make a good home
# And I see an indicator that this application is "In Progress"
RSpec.describe 'the application' do
  before(:each) do
    @application = Application.create({name: "Person_1", street_address: "123 Fake St", city: "Fakecity", zipcode: "12345", description: " ", status: "In Progress" })
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
  end
  describe 'creates a new application' do
    it 'has a link on the pets index' do
      visit '/pets'
      click_on 'Start an Application'
      expect(current_path).to eq('/applications/new')
    end

    it 'creates a new application with the form' do
      visit '/applications/new'
      fill_in 'Name', with: "Person_2"
      fill_in 'Street address', with: "123 Fake St"
      fill_in "City", with: "Fakecity"
      fill_in "Zipcode", with: "12345"
      click_on "Submit"
      application = Application.last
      expect(current_path).to eq("/applications/#{application.id}")
      expect(page).to have_content("Person_2")
      expect(page).to have_content("In Progress")
    end
  end

    describe 'an incomplete application' do
        # As a visitor
        # When I visit the new application page
        # And I fail to fill in any of the form fields
        # And I click submit
        # Then I am taken back to the new applications page
        # And I see a message that I must fill in those fields.
      it 'redirects back to from when incomplete' do
        visit '/applications/new'
        click_on "Submit"
        #save_and_open_page
        expect(current_path).to eq('/applications/new')
        expect(page).to have_content("Error: Name can't be blank, Street address can't be blank, City can't be blank, Zipcode can't be blank")
      end
    end
end
