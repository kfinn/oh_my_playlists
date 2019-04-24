class ArtistAppearancesController < ApplicationController
  def index
    @artist_appearances = current_subscriber.artist_appearances.upcoming.by_date
  end
end
