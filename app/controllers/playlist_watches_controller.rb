class PlaylistWatchesController < ApplicationController
  def index
    @playlist_watches = current_subscriber.playlist_watches.order(:created_at).includes(:artist_watches, :playlist_snapshot)
  end

  def create
    @playlist_watch = current_subscriber.playlist_watches.build(spotify_playlist_id: params[:playlist_id])
    if @playlist_watch.save
      redirect_to playlist_watches_path, notice: "Watching #{@playlist_watch.name}"
    else
      redirect_to(
        playlists_path,
        alert: "Failed to watch #{@playlist_watch.name}: #{@playlist_watch.errors.full_messages.join(', ')}"
      )
    end
  end
end
