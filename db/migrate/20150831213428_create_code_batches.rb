class CreateCodeBatches < ActiveRecord::Migration
  def change
    create_table :code_batches do |t|

      t.timestamps null: false
    end
  end
end
