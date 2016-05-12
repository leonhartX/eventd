class ChangeStateDataType < ActiveRecord::Migration[5.0]
  def change
    change_column :attendances, :state, :string 
  end
end
