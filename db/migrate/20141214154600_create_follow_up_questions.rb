class CreateFollowUpQuestions < ActiveRecord::Migration
  def change
    create_table :follow_up_questions do |t|
      t.text :question

      t.timestamps
    end
  end
end
