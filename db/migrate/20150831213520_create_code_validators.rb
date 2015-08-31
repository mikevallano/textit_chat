class CreateCodeValidators < ActiveRecord::Migration
  def change
    create_table :code_validators do |t|
      t.integer :max_redemptions
      t.integer :max_unique_redemptions

      t.timestamps null: false
    end
  end
end
