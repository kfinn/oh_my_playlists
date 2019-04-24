class PlaylistsController < ApplicationController
  def index
    @playlists = current_subscriber.playlists
  end
end
