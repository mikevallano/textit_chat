class CreateSentPushNotifications < ActiveRecord::Migration
  def change
    create_table :sent_push_notifications do |t|
      t.belongs_to :push_notification, index: true
      t.belongs_to :client, index: true

      t.timestamps
    end
  end
end
