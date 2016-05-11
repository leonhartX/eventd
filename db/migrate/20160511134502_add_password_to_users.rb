class AddPasswordToUsers < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.column :encrypted_password, :string, null: false, default: ""
    end
  end
end