class SearchController < ApplicationController
  def index
    if params[:q]
      @response = Song.search(query: {match: {lyric_jp: params[:q]}, analyzer: "kuromoji"}, highlight: { fields: { lyric_jp: {}} }).page(params[:page])
    end
  end
end
