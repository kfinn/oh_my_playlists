class PlaylistsController < ApplicationController
  def index
    @watched_spotify_playlist_ids = current_subscriber.watched_spotify_playlist_ids
    @playlists = current_subscriber.playlists
  end
end
