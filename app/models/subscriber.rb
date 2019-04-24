class Subscriber < ApplicationRecord
  devise :trackable, :omniauthable, omniauth_providers: [:spotify]

  validates :spotify_uid, :email, :spotify_credential_token, :spotify_credential_refresh_token, :spotify_credential_expires_at, :spotify_credential_expires, presence: true

  has_many :playlist_watches
  has_many :artist_appearances, through: :playlist_watches

  class << self
    def from_omniauth(omniauth)
      find_or_initialize_by(spotify_uid: omniauth[:uid]).tap do |subscriber|
        subscriber.update!(subscriber_params_from_omniauth(omniauth))
      end
    end

    private

    def subscriber_params_from_omniauth(omniauth)
      {
        email: omniauth[:info][:email],
        spotify_credential_token: omniauth[:credentials][:token],
        spotify_credential_refresh_token: omniauth[:credentials][:refresh_token],
        spotify_credential_expires_at: Time.zone.at(omniauth[:credentials][:expires_at]).to_datetime,
        spotify_credential_expires: omniauth[:credentials][:expires]
      }.compact
    end
  end

  def playlists
    @playlists ||= spotify_user.playlists(limit: 50)
  end

  def spotify_user
    @spotify_user ||= RSpotify::User.new to_rspotify_params
  end

  private

  def to_rspotify_params
    {
      info: {
        id: spotify_uid,
        email: email
      },
      credentials: {
        token: spotify_credential_token,
        refresh_token: spotify_credential_refresh_token,
        expires_at: spotify_credential_expires_at.to_i,
        expires: spotify_credential_expires
      }
    }.with_indifferent_access
  end
end
