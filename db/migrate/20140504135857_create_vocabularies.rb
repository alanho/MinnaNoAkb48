class CreateVocabularies < ActiveRecord::Migration
  def change
    create_table :vocabularies do |t|
      t.string :kanji
      t.string :furigana
      t.string :romaji
      t.string :meaning
      t.string :level

      t.integer :song_ids, array: true

      t.timestamps
    end
  end
end
