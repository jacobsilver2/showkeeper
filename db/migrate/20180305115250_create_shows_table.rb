class CreateShowsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :shows do |t|
      t.string :headliner
      t.string :support
      t.string :date
      t.string :doors_at
      t.integer :user_id
    end
  end
end
