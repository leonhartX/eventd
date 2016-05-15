class AddSharableToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :sharable, :boolean, default: false
  end
end
