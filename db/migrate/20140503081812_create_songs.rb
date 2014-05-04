class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :slug, unique: true
      t.string :path, unique: true
      t.string :name_jp
      t.string :name_romaji
      t.string :name_en
      t.text :lyric_jp
      t.text :lyric_romaji
      t.text :lyric_en

      t.timestamps
    end

    add_index :songs, :slug, unique: true
  end
end
