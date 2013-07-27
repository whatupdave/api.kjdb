class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.references :artist, null: false
      t.string :slug,       null: false
      t.string :name,       null: false
      t.datetime :release_date
      t.timestamps

      t.index :slug, unique: true
    end
  end
end
