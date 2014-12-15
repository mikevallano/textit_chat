class CreateDiagnosedHealthProblems < ActiveRecord::Migration
  def change
    create_table :diagnosed_health_problems do |t|
      t.belongs_to :health_problem, index: true
      t.belongs_to :client, index: true

      t.timestamps
    end
  end
end
