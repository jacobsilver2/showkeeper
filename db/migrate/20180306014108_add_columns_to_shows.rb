class AddColumnsToShows < ActiveRecord::Migration[5.1]
  def change
    add_column :shows, :blurb, :string
    add_column :shows, :headliner_url, :string
  end
end
