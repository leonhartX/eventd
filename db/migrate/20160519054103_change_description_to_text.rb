class ChangeDescriptionToText < ActiveRecord::Migration[5.0]
  def change
  	change_column :events, :description, :text, limit: 10000
  end
end
