require 'rails_helper'
# [ ] done
#
# Application Show Page
#
# As a visitor
# When I visit an applications show page
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
RSpec.describe "application show page" do
  before(:each) do
    @application = Application.create({name: "applicant_1", street_address: "123 fake", city: "Fakecity", zipcode: "12345", description: "cus dogs", status: "pending" })
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
  end
  describe 'it has a page to visit' do
    it 'visits a page' do# binding.pry
      visit "/applications/#{@application.id}"
      expect(current_path).to eq("/applications/#{@application.id}")
    end

    it 'displays the applicants inforation' do
      visit "/applications/#{@application.id}"
      expect(page).to have_content(@application.name)
      expect(page).to have_content(@application.street_address)
      expect(page).to have_content(@application.city)
      expect(page).to have_content(@application.zipcode)
      expect(page).to have_content(@application.description)
      expect(page).to have_content(@application.status)
    end
  end

  describe 'has a search feature' do
    it 'has a section to Add a Pet to this Application' do
      visit "/applications/#{@application.id}"
      within ".search-pet" do
        expect(page).to have_content("Search for a pet")
        expect(page).to have_button("Search")
        fill_in("Pet name", with: "#{@pet_1.name}")
        click_button("Search")
        expect(current_path).to eq("/applications/#{@application.id}")
      end
      expect(page).to have_content("#{@pet_1.name}")
    end
#     As a visitor
# When I visit an application's show page
# And I search for a Pet by name
# And I see the names Pets that match my search
# Then next to each Pet's name I see a button to "Adopt this Pet"
# When I click one of these buttons
# Then I am taken back to the application show page
# And I see the Pet I want to adopt listed on this application
    it 'can add pets after the search' do
      visit "/applications/#{@application.id}"
      within ".search-pet" do
      expect(page).to have_content("Search for a pet")
      expect(page).to have_button("Search")
      fill_in("Pet name", with: "#{@pet_1.name}")
      click_button("Search")
      end
      expect(current_path).to eq("/applications/#{@application.id}")
      click_on("Adopt #{@pet_1.name}")
      expect(current_path).to eq("/applications/#{@application.id}")

      expect(page).to have_content("Applied for: #{@pet_1.name}")
    end
    # As a visitor
    # When I visit an application's show page
    # And I have added one or more pets to the application
    # Then I see a section to submit my application
    # And in that section I see an input to enter why I would make a good owner for these pet(s)
    # When I fill in that input
    # And I click a button to submit this application
    # Then I am taken back to the application's show page
    # And I see an indicator that the application is "Pending"
    # And I see all the pets that I want to adopt
    # And I do not see a section to add more pets to this application
    it 'can be submitted after adding pets' do
      visit "/applications/#{@application.id}"
      within ".search-pet" do
      fill_in("Pet name", with: "#{@pet_1.name}")
      click_button("Search")
      end
      click_on("Adopt #{@pet_1.name}")
      within ".search-pet" do
      fill_in("Pet name", with: "#{@pet_2.name}")
      click_button("Search")
      end
      click_on("Adopt #{@pet_2.name}")
      expect(current_path).to eq("/applications/#{@application.id}")
      expect(page).to have_button("Submit your application")
      save_and_open_page
      #expect(page).to_not have_content("Search for a pet name")
    end

  end
end
