class SearchController < ApplicationController
  def index
    if params[:q]
      @response = Song.search(query: {match: {lyric_jp: params[:q]}}, highlight: { fields: { lyric_jp: {}} },).page(params[:page]).per(100)
    end
  end
end
