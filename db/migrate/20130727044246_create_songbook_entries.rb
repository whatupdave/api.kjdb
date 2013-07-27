class CreateSongbookEntries < ActiveRecord::Migration
  def change
    create_table :songbook_entries do |t|
      t.references :songbook, null: false
      t.string :artist,       null: false
      t.string :title,        null: false
      t.datetime :created_at, null: false

      t.references :track

      t.index [:artist, :title], unique: true
    end
  end
end
