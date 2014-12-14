class AddGeneralInformationRequestedToClients < ActiveRecord::Migration
  def change
    change_table :clients do |t|
      t.boolean :general_information_requested, default: false
    end
  end
end
