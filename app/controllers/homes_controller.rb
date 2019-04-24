class HomesController < ApplicationController
  skip_before_action :authenticate_subscriber!

  def show
    redirect_to playlists_path if current_subscriber.present?
  end
end
