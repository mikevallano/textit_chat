class CreateConsultationQuestions < ActiveRecord::Migration
  def change
    create_table :consultation_questions do |t|
      t.text :preview
      t.text :question

      t.timestamps
    end
  end
end
