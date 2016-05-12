class CreateAttendances < ActiveRecord::Migration[5.0]
  def change
    create_table :attendances do |t|
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true
      t.integer :state

      t.timestamps
    end
    add_index :attendances, [:user_id, :event_id], unique: true
  end
end
