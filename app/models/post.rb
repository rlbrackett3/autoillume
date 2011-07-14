require 'carrierwave/orm/activerecord'

class Post < ActiveRecord::Base

  attr_accessible :title, :body, :state, :published_at, :sections_attributes, :photo_sections_attributes, :text_sections_attributes#, :photos_attributes#, :admin_id #protect the admin id

  belongs_to :admin
  has_many :comments, dependent: :destroy
  has_many :sections, dependent: :destroy
  has_many :photo_sections, dependent: :destroy, class_name: "Section", conditions: { section_type: 'photo' }
  has_many :text_sections, dependent: :destroy, class_name: "Section", conditions: { section_type: 'text' }
  # has_many :photos, through: :sections

  accepts_nested_attributes_for :sections, allow_destroy: true
  accepts_nested_attributes_for :photo_sections, allow_destroy: true,:reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
  accepts_nested_attributes_for :text_sections, allow_destroy: true,:reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
  # accepts_nested_attributes_for :photos, allow_destroy: true

  # States and Transitions with state_machine gem
  state_machine :initial => :initial do
    # event :preview do
    #   transition :initial => :preview
    #   # transition :draft => :preview
    # end

    event :draft do
      transition all => :draft
    end

    event :published do
      transition all => :published
    end
  end

  #constants
  TITLE_MAX_LENGTH = 200

  validates :title, presence: true,
                    length: { maximum: TITLE_MAX_LENGTH }
  # validates :body,               presence: true
  # validates :published_at,  presence: true, allow_blank: true
  validates :admin_id, presence: true
  validates :state, presence: true
  validates_associated :sections, :photo_sections, :text_sections, :comments#, :photos

  # scopes
  scope :drafts, where(state: 'draft')
  scope :published, where(state: 'published')

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

