class ExternalLink < ActiveRecord::Base
  include RankedModel #test for this
  ranks :link_order #test for this

  attr_accessible :title, :url, :description, :link_order

  url_regex = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix

  validates :title,                presence: true,
                                          uniqueness: true
  validates  :url,                 presence: true,
                                          uniqueness: true,
                                          format: { with: url_regex, message: "Your URL is not properly formatted." }
  validates :description,    length: { within: 3..254, allow_blank: true }
  validates :link_order,      presence: true
end
