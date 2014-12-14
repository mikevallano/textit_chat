class CreatePushNotifications < ActiveRecord::Migration
  def change
    create_table :push_notifications do |t|
      t.string :tag
      t.string :message

      t.timestamps
    end
  end
end
