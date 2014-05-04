class SearchController < ApplicationController
  def index
    @response = Song.search(query: {match: {lyric_jp: params[:q]}, analyzer: "kuromoji"}, highlight: { fields: { lyric_jp: {}} }).page(params[:page])
  end
end
