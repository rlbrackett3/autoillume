class Page < ActiveRecord::Base
  attr_accessible :title, :permalink, :content

  validates :title,               presence: true,
                                          uniqueness: true
  validates  :permalink,    presence: true,
                                          uniqueness: true
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

