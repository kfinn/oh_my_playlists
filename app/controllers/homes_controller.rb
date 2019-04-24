class HomesController < ApplicationController
  skip_before_action :authenticate_subscriber!

  def show
    redirect_to artist_appearances_path if current_subscriber.present?
  end
end
