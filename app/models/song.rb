require "open-uri"
require "addressable/uri"

class Song < ActiveRecord::Base
  include Searchable
  include IndexSetup

  def highlighted_lyrics(level)
    return lyric_jp if vocabs_of_level(level).count == 0

    query = vocabs_of_level(level).map(&:text).join(" ")
    
    response = Song.search({
      query: {
        filtered: {
          filter: {
            ids: {
              values: [id]
            }
          },
          query: {
            match: {
              _all: query
            }
          }
        }
      },
      highlight: {
        fields: {
          lyric_jp: {
            number_of_fragments: 0
          },
          name_jp: {}
        }
      }
    })

    response.first.highlight.lyric_jp[0]
  end

  def vocabs_of_level(level)
    Vocabulary.of_level(level).where(id: vocab_ids)
  end
end
