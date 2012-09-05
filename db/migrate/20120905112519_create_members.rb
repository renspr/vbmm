class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string  :name
      t.string  :location_string
      t.float   :longitude
      t.float   :latitude
      t.boolean :gmaps
      t.timestamps
    end

    add_index :members, :name, unique: true
  end
end
