class Subscriber < ApplicationRecord
  devise :trackable, :omniauthable, omniauth_providers: [:spotify]

  validates :spotify_uid, :email, :spotify_credential_token, :spotify_credential_refresh_token, :spotify_credential_expires_at, :spotify_credential_expires, presence: true

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
end
