class DeleteUselessColumnFromUser < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.remove_index :email
      t.remove_index :reset_password_token
      t.remove :email, :encrypted_password, :reset_password_token, :reset_password_sent_at
    end
  end
end
