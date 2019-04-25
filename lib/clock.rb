require 'clockwork'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'config', 'boot'))
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'config', 'environment'))

module Clockwork
  every(1.day, 'snapshot_all_playlsts') { AllPlaylistsSync.create! }
  every(1.day, 'sync_with_oh_my_rockness') { OhMyRocknessSync.create! }
end
