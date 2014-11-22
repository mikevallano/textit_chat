class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :beneficiary_number
      t.float :subtotal
      t.float :shipping
      t.float :taxes
      t.string :state

      t.timestamps
    end
  end
end
