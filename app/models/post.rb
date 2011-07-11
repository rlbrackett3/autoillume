require 'carrierwave/orm/activerecord'

class Post < ActiveRecord::Base
  # self.abstract = true

  attr_accessible :title, :body, :state, :published_at, :sections_attributes#, :photos_attributes#, :admin_id #protect the admin id

  belongs_to :admin
  has_many :comments, dependent: :destroy
  has_many :sections, dependent: :destroy
  # has_many :photos, through: :sections

  accepts_nested_attributes_for :sections, allow_destroy: true
  # accepts_nested_attributes_for :photos, allow_destroy: true

  # States and Transitions with state_machine gem
  state_machine :initial => :initial do
    event :preview do
      transition :draft => :preview
    end

    event :draft do
      transition all => :draft
    end

    event :published do
      transition all => :published
    end
  end

  #constants
  TITLE_MAX_LENGTH = 200

  validates :title,                 presence: true,
                                           length: { maximum: TITLE_MAX_LENGTH }
  # validates :body,               presence: true
  # validates :published_at,  presence: true, allow_blank: true
  # validates :admin_id,        presence: true
  validates :state,               presence: true
  validates_associated :sections
  # validate :published_at_is_valid_datetime #not tested yet

  # # scopes
  scope :drafts, where(state: 'draft')
  scope :published, where(state: 'published')

private
  # possible work around for validating datetime, not tested yet
  # def published_at_is_valid_datetime
  #   errors.add(:published_at, 'must be a valid datetime') if ((DateTime.parse(happened_at) rescue ArgumentError) == ArgumentError)
  # end

end





# == Schema Information
#
# Table name: posts
#
#  id           :integer         not null, primary key
#  title        :string(255)
#  body         :text
#  created_at   :datetime
#  updated_at   :datetime
#  admin_id     :integer
#  state        :string(255)
#  published_at :datetime
#

