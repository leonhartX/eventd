class AddOmniIndexToUser < ActiveRecord::Migration[5.0]
  def change
  	change_column_null :users, :uid, false
  	change_column_null :users, :provider, false
  	add_index :users, [:uid, :provider], unique: true
  end
end
