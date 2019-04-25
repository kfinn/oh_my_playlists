class ArtistWatch < ApplicationRecord
  has_many :artist_watch_song_watches, inverse_of: :artist_watch
  has_many :song_watches, through: :artist_watch_song_watches
  has_many :artist_appearances, inverse_of: :artist_watch

  def spotify_artist_url
    artist.external_urls['spotify']
  end

  def self.without_appearance_for(oh_my_rockness_show_id:, oh_my_rockness_band_id:)
    where(<<~SQL.squish)
      NOT EXISTS (#{
        ArtistAppearance
          .where(
            oh_my_rockness_show_id: oh_my_rockness_show_id,
            oh_my_rockness_band_id: oh_my_rockness_band_id
          )
          .where("#{ArtistAppearance.table_name}.artist_watch_id = #{table_name}.id")
          .to_sql
      })
    SQL
  end

  private

  def artist
    @artist ||= RSpotify::Artist.find(spotify_artist_id)
  end
end
