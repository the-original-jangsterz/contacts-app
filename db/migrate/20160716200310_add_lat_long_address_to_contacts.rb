class AddLatLongAddressToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :latitude, :float
    add_column :contacts, :longitude, :float
    add_column :contacts, :address, :string
  end
end
