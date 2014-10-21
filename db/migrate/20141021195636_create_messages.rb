class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :from
      t.string :to
      t.text :message
      t.datetime :sent_at
      t.boolean :sent
      t.boolean :delivered

      t.timestamps
    end
  end
end
