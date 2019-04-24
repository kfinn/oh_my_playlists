class ArtistWatchSongWatch < ApplicationRecord
  belongs_to :artist_watch
  belongs_to :song_watch
end
