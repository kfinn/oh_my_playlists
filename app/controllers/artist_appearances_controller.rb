class ArtistAppearancesController < ApplicationController
  def index
    @artist_appearances = current_subscriber.artist_appearances.upcoming.by_date
    @song_watches = current_subscriber.song_watches
  end
end
