class CreateContactGroups < ActiveRecord::Migration
  def change
    create_table :contact_groups do |t|
      t.integer :contact_id
      t.integer :group_id

      t.timestamps null: false
    end
  end
end
