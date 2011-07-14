require 'carrierwave/orm/activerecord'

class Photo < ActiveRecord::Base
  attr_accessible :title, :image, :image_cache, :section_id

  # Associations
  belongs_to :section
  # belongs_to :post

 # CarrierWave
  mount_uploader :image, ImageUploader

  # Validations
  validates :title,             length: { within: 3..254, allow_blank: true }
  validates :image,         presence: true
  # validates :section_id,   presence: true # causes issues with nested validation

  # Callbacks
  before_validation :save_dimensions, :save_orientation

  # Scopes

  private

  def save_dimensions
    if image.path
      self.width  = MiniMagick::Image.open(image.path)[:width]
      self.height = MiniMagick::Image.open(image.path)[:height]
    end
  end

  def save_orientation
    if image.path
      self.orientation = (height.to_i > width.to_i) ? 'portrait' : 'landscape'
    end
  end

end

# == Schema Information
#
# Table name: photos
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  width       :integer
#  height      :integer
#  orientation :string(255)
#  section_id  :integer
#  created_at  :datetime
#  updated_at  :datetime
#

