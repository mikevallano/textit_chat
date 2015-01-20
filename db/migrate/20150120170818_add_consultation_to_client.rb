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
      t.text :other_illness_details
      t.boolean :other_std
      t.text :other_std_details
      t.boolean :previous_termination_attempt
      t.boolean :previous_termination_attempt_bleeding
      t.text :other_information
    end
  end
end