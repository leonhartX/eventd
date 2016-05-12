class AddUserReferenceToEvent < ActiveRecord::Migration[5.0]
  def change
  	add_reference :events, :user, foreign_key: true
  	change_column_null :events, :title, false
  	change_column_null :events, :hold_at, false
  	change_column_null :events, :capacity, false
  	change_column_null :events, :location, false
  	change_column_null :events, :owner, false
  end
end
