class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :hold_at
      t.integer :capacity
      t.string :location
      t.string :owner
      t.string :description

      t.timestamps
    end
  end
end
