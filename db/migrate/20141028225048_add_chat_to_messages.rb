class AddChatToMessages < ActiveRecord::Migration
  def change
    add_reference :messages, :chat, index: true
  end
end
