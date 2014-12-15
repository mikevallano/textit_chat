class AddInfoToClients < ActiveRecord::Migration
  def change
    change_table :clients do |t|
      t.string :country
      t.date :birthday
      t.string :language
      t.integer :num_children
      t.boolean :has_unwanted, default: false
      t.string :confirmation_method
    end
  end
end
