class PlaylistWatchesController < ApplicationController
  def create
    @playlist_watch = current_subscriber.playlist_watches.build(spotify_playlist_id: params[:playlist_id])
    if @playlist_watch.save
      redirect_to playlists_path, notice: "Watching #{@playlist_watch.name}"
    else
      redirect_to(
        playlists_path,
        alert: "Failed to watch #{@playlist_watch.name}: #{@playlist_watch.errors.full_messages.join(', ')}"
      )
    end
  end
end
