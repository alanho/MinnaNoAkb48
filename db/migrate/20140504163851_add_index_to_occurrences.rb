class AddIndexToOccurrences < ActiveRecord::Migration
  def change
    add_index :occurrences, :vocabulary_id
    add_index :occurrences, :song_id
  end
end
