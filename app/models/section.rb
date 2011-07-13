require 'carrierwave/orm/activerecord'

class Section < ActiveRecord::Base
  attr_accessible :body, :position, :photo_attributes, :post_id

  belongs_to :post
  has_one    :photo, dependent: :destroy

  accepts_nested_attributes_for :photo, allow_destroy: true

  # Validations
  validates :body,               length: { within: 3..4096, allow_blank: true }
  validates :position,          presence: true, on: :create
  # validates :post_id,           presence: true
  validates_associated :photo

  #scopes
  scope :forward, order('position ASC')

end

# == Schema Information
#
# Table name: sections
#
#  id         :integer         not null, primary key
#  body       :text
#  position   :integer         default(0)
#  post_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

