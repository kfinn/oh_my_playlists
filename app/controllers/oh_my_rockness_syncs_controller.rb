class OhMyRocknessSyncsController < ApplicationController
  def create
    @oh_my_rockness_sync = OhMyRocknessSync.new
    if @oh_my_rockness_sync.save
      redirect_to artist_appearances_path, notice: "Syncing"
    else
      redirect_to(
        artist_appearances_path,
        alert: "Failed to sync: #{@oh_my_rockness_sync.errors.full_messages.join(', ')}"
      )
    end
  end
end
