class ArtistWatch < ApplicationRecord
  has_many :artist_watch_song_watches, inverse_of: :artist_watch
  has_many :song_watches, through: :artist_watch_song_watches
  has_many :artist_appearances, inverse_of: :artist_watch
end
