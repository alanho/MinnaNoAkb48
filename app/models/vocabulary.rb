require "csv"

class Vocabulary < ActiveRecord::Base
  scope :of_level, -> (level) { where(level: level) }

  def text
    kanji || furigana
  end

  def matching_doc
    @matching_doc ||= Song.search(query: {match: {_all: text}}, size: 1000, fields: ["id"])
  end

  class << self
    def import
      delete_all

      csv_path = Rails.root.join("lib", "data", "jlpt_all_vocab.csv")

      CSV.foreach(csv_path, headers: :first_row) do |row|
        create({
          kanji: row["Kanji"],
          furigana: row["Furigana"],
          meaning: row["Meaning"],
          level: row["Level"]
        })
      end
    end

    def reset_occurrences
      Song.find_each do |song|
        song.update_attribute(:vocab_ids,[])
      end

      Vocabulary.find_each do |vocab|
        vocab.update_attribute(:song_ids,[])
      end
    end

    def build_occurrences
      reset_occurrences

      find_each do |vocab|
        response = Song.search(query: {match: {_all: vocab.text}}, size: 1000, fields: ["id"])

        vocab.song_ids = vocab.matching_doc.records.pluck(:id)
        vocab.save

        Song.where(id: vocab.song_ids).find_each do |song|
          song.vocab_ids = song.vocab_ids + [vocab.id]
          song.save
        end
      end
    end
  end
end
