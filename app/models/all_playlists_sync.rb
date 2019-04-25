class AllPlaylistsSync < ApplicationRecord
  def self.create!
    delay.sync!
  end

  def self.sync!
    PlaylistWatch.transaction do
      PlaylistWatch.all.find_each do |playlist_watch|
        playlist_watch.refresh_song_watches!
      end
    end
  end
end
