class CreateOccurrences < ActiveRecord::Migration
  def change
    create_table :occurrences do |t|
      t.belongs_to :vocabulary
      t.belongs_to :song

      t.timestamps
    end
  end
end
