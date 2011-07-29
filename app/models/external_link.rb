class ExternalLink < ActiveRecord::Base
  include RankedModel #test for this
  ranks :link_order #test for this

  attr_accessible :title, :url, :description, :link_order

  validates :title,                presence: true,
                                          uniqueness: true
  validates  :url,                 presence: true,
                                          uniqueness: true
  validates :description,    length: { within: 3..254, allow_blank: true }
  validates :link_order,      presence: true
end
