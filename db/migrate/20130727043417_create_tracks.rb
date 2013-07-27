class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.references :album,  null: false
      t.string :slug,       null: false
      t.string :name,       null: false
      t.timestamps
      
      t.index :slug, unique: true
    end
  end
end
