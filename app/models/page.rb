class Page < ActiveRecord::Base
  include RankedModel #test for this
  ranks :page_order #test for this

  attr_accessible :title, :permalink, :content, :page_order

  validates :title,               presence: true,
                                          uniqueness: true
  validates  :permalink,    presence: true,
                                          uniqueness: true
  validates :page_order,    presence: true
end

# == Schema Information
#
# Table name: pages
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  permalink  :string(255)
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#

