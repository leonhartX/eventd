class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :content, limit: 2000, null: false
      t.references :event, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :comments, [:event_id, :user_id]
  end
end
