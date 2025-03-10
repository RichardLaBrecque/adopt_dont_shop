require 'rails_helper'

RSpec.describe Application do
  describe 'relationships' do
    it{ should have_many(:pet_applications)}
    it{ should have_many(:pets).through(:pet_applications)}
  end

  describe 'class methods'do
    it 'can find all pending applications' do
      @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
      @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
    end
  end
end
