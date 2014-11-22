class CreateOrderUpdates < ActiveRecord::Migration
  def change
    create_table :order_updates do |t|
      t.string :confirmation_code
      t.belongs_to :user, index: true
      t.belongs_to :order, index: true

      t.timestamps
    end
  end
end
