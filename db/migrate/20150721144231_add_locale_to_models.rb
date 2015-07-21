class AddLocaleToModels < ActiveRecord::Migration
  def change
    add_column :faqs, :locale, :string
    add_column :consultation_questions, :locale, :string
    add_column :follow_up_questions, :locale, :string
    add_column :health_problems, :locale, :string
    add_column :users, :locale, :string
  end
end
