class Reply < ActiveRecord::Base
  attr_accessible :body

  belongs_to :comment
  belongs_to :admin

  # Validations
  validates :body,               presence: true,
                                           length: { within: 3..1024 }
  validates :admin_id,        presence: true
  validates :comment_id,   presence: true

  # Scopes
  default_scope order('created_at DESC') # test

end




# == Schema Information
#
# Table name: replies
#
#  id         :integer         not null, primary key
#  body       :text
#  comment_id :integer
#  created_at :datetime
#  updated_at :datetime
#  admin_id   :integer
#

