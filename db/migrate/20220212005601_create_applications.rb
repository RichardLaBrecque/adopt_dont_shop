class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :street_address
      t.string :city
      t.string :zipcode
      t.string :description
      t.string :status, :default => "In Progress"
      t.timestamps
    end
  end
end
