class AddIsReceivedToMessages < ActiveRecord::Migration
  def change
    change_table :messages do |t|
      t.boolean :sent_by_system
      t.string :relayer
    end
  end
end
