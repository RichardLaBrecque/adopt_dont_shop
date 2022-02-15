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
      @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @shelter_2 = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      @shelter_3 = Shelter.create(name: 'Hollywood shelter', city: 'Irvine, CA', foster_program: false, rank: 7)
    end
    it 'has an admin shelters index page' do
      visit '/admin/shelters'
    end

    it 'lists shelters in reverse alphabetical order' do
      visit '/admin/shelters'
      expect(@shelter_2.name).to appear_before(@shelter_3.name)
      expect(@shelter_3.name).to appear_before(@shelter_1.name)
    end
  end
end
