class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.string :code
      t.belongs_to :code_validator, index: true, foreign_key: true
      t.belongs_to :code_batch, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
