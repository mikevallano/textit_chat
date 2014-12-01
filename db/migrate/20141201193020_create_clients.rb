class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :phone_number
      t.string :name
      t.text :address

      t.timestamps
    end
  end
end
