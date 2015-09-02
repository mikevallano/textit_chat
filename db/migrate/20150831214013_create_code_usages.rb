class CreateCodeUsages < ActiveRecord::Migration
  def change
    create_table :code_usages do |t|
      t.belongs_to :code, index: true, foreign_key: true
      t.belongs_to :client, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
