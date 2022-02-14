# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
shelter_2 = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
shelter_3 = Shelter.create(name: 'Hollywood shelter', city: 'Irvine, CA', foster_program: false, rank: 7)
shelter_1.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald')
shelter_2.pets.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster')
shelter_3.pets.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true)
shelter_1.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'George Hairlesson')
shelter_2.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
shelter_3.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
