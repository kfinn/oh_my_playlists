class ArtistAppearancesController < ApplicationController
  def index
    @latest_oh_my_rockness_sync = OhMyRocknessSync.latest
    @artist_appearances = current_subscriber.artist_appearances.upcoming.by_date
    @song_watches = current_subscriber.song_watches
  end
end
