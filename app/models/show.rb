class Show
  include Her::Model
  use_api OH_MY_ROCKNESS_API

  scope :just_announced, -> { where just_announced: true }
  scope :in_new_york, -> { where regioned: 1 }

  has_many :cached_bands, class_name: 'Band'
end
