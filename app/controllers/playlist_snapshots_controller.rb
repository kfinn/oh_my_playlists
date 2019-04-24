class PlaylistSnapshotsController < ApplicationController
  def create
    @playlist_snapshot = current_subscriber.playlist_watches.find(params[:playlist_watch_id]).playlist_snapshots.build
    if @playlist_snapshot.save
      redirect_to playlist_watches_path, notice: "Updating #{@playlist_snapshot.playlist_watch.name}"
    else
      redirect_to(
        playlist_watchs_path,
        alert: "Failed to updates #{@playlist_watch.playlist_snapshot&.name}: #{@playlist_snapshot.errors.full_messages.join(', ')}"
      )
    end
  end
end
