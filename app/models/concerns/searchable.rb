module Searchable
  extend ActiveSupport::Concern
  
  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    settings index: { analysis: { analyzer: { default: { type: "kuromoji" }}} } do
      mappings dynamic: 'false' do
        indexes :name_jp, analyzer: 'kuromoji'
        indexes :lyric_jp, analyzer: 'kuromoji'
      end
    end
  end
end