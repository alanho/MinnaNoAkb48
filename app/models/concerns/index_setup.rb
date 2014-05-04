module IndexSetup
  extend ActiveSupport::Concern
  
  included do
  end

  module ClassMethods
    def fetch_all
      uri = Addressable::URI.parse("http://stage48.net/studio48/lyricsindex_akb48.html")
      doc = Nokogiri::HTML(open("http://stage48.net/studio48/lyricsindex_akb48.html"))

      doc.search(".two-columns .column .content ul p").each do |section|
        section.inner_html.split("<br>").each do |song|
          song_node = Nokogiri::HTML(song)

          if song_link = song_node.at("a")
            song_url = uri + song_link["href"]
            song_slug = song_link.text.parameterize
            fetch_one(song_slug, song_url)
          end
        end
      end
    end

    def fetch_one(slug, url)
      Song.find_or_create_by(slug: slug, path: url.basename).tap do |song|
        doc = Nokogiri::HTML(open(url))
        
        # [0] => kana, [1] => romaji, [2] => english
        song_names = doc.search(".post.greenbox .title").text.split("|").map(&:strip)
        lyrics = doc.search(".two-columns .column")  

        song.update_attributes({
          name_jp: song_names[0],
          lyric_jp: ((lyrics[0].at("ul").text.strip.lines.map(&:strip).join("\n")) rescue nil),

          name_romaji: song_names[1],
          lyric_romaji: ((lyrics[1].at("ul").text.strip.lines.map(&:strip).join("\n")) rescue nil),

          name_en: song_names[2],
          lyric_en: ((lyrics[2].at("ul").text.strip.lines.map(&:strip).join("\n")) rescue nil),
        })
      end
    end

    def create_index
      self.__elasticsearch__.create_index! force: true
    end
  end
end