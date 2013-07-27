class CreateSongbooks < ActiveRecord::Migration
  def change
    create_table :songbooks do |t|
      t.string :slug, null: false
      t.string :name, null: false
      t.timestamps

      t.index :slug, unique: true
    end
  end
end
