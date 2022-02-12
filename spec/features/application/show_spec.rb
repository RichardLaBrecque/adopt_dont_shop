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
    end
  end
end
