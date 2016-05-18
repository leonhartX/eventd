class ChangeTokenLength < ActiveRecord::Migration[5.0]
  def change
  	change_column :users, :token, :string, limit: 1000
  end
end
