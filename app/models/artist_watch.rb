class ArtistWatch < ApplicationRecord
  has_many :artist_watch_song_watches, inverse_of: :artist_watch
  has_many :song_watches, through: :artist_watch_song_watches
  has_many :playlist_watches, through: :song_watches
  has_many :subscribers, through: :playlist_watches
end
