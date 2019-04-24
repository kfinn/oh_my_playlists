class Show
  include Her::Model
  use_api OH_MY_ROCKNESS_API

  scope :just_announced, -> { where just_announced: true }
  scope :in_new_york, -> { where regioned: 1 }

  has_many :cached_bands, class_name: 'Band'

  def summary
    "#{cached_bands.map(&:name).to_sentence} at #{venue[:name]} on #{starts_at.to_date}"
  end
end
