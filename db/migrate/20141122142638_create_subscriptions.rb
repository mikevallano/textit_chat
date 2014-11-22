class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.belongs_to :user, index: true
      t.belongs_to :chat, index: true
      t.datetime :last_read_at

      t.timestamps
    end
  end
end
