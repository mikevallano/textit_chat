class AddConsultationToClient < ActiveRecord::Migration
  def change
    change_table :clients do |t|
      t.boolean :confirmed_pregnancy
      t.datetime :normal_period_start_day
      t.boolean :termination_chosen
      t.boolean :informed_risks_pills
      t.boolean :informed_iud
      t.text :informed_iud_statement
      t.boolean :other_illness
      t.boolean :other_std
      t.boolean :previous_termination_attempt
      t.boolean :previous_termination_attempt_bleeding
    end
  end
end