require 'test_helper'

class ReplyTest < ActiveSupport::TestCase
  # setup
  ################################
  def setup
    @reply = replies :valid
    @admin = admins :foo
    @comment = comments :approved
  end
  ################################

  # create Reply object with valid attr
  ################################
  test 'should have valid attr' do
    reply = Reply.new
    # assert post record build in DB
    assert reply
    #assert not valid because body is required
    assert_nil reply.body, "Reply has a body."
    #assert not valid because a comment is required
    assert_nil reply.comment_id, "Reply has a comment."
    #assert not valid because a admin is required
    assert_nil reply.admin_id, "Reply has a admin."
    # assert that a valid record cannot be saved
    assert !reply.valid?, "Saved an invalid Reply."

    # Load in valid data
    reply.body = replies(:valid).body
    reply.comment_id = comments(:approved).id
    reply.admin_id = admins(:foo).id

    assert reply.valid?

    # check that all values were set correctly with valid data
    assert_equal reply.body, replies(:valid).body
    assert_equal reply.comment_id, comments(:approved).id
    assert_equal reply.admin_id, admins(:foo).id

  end
  ################################

  # respond to attr methods
  ################################
  test 'should respond to body' do
    assert replies(:valid).body, "Reply does not respond to body."
  end

  test 'should respond to created_at' do
    assert replies(:valid).created_at, "Reply does not respond to created_at."
  end

  test 'should respond to updated_at' do
    assert replies(:valid).updated_at, "Reply does not respond to updated_at."
  end

  test 'should respond to comment_id' do
    assert replies(:valid).comment_id, "Reply does not respond to comment_id."
  end

  test 'should respond to id' do
    assert replies(:valid).id, "Reply does not respond to id."
  end

  test 'should respond to admin_id' do
    assert replies(:valid).admin_id, "Reply does not respond to admin_id."
  end
  ################################

  # body
  ################################
  test 'body:should not save a reply without a body' do
    @reply.body = nil
    assert !@reply.valid?, "Saved an invalid reply with a nil body."
  end

  test 'body: should not save a reply with a body less than 3 chars' do
    short_body = "a" * 2
    @reply.body = short_body
    assert !@reply.valid?, "Saved an invalid reply with body shorter than 3 chars."
  end

  test 'body: should not save a reply with a body longer than 1024 chars' do
    long_body = "a" * 1025
    @reply.body = long_body
    assert !@reply.valid?, "Saved an invalid reply with a body longer than 1024 chars."
  end
  ################################

  # associations
  ################################
  test 'associated: should not create a valid reply without a comment' do
    reply = Reply.create body: "foobar", admin_id: @admin.id
    assert !reply.valid?, "Saved an invalid reply without a comment."
  end

  test 'associated: should not create a valid reply without an admin' do
    reply = Reply.create body: "foobar", comment_id: @comment.id
    assert !reply.valid?, "Saved an invalid reply without an admin."
  end
  ################################

  # tests
  ################################

  ################################

  # scopes
  ################################
  test 'default scope should be order created_at DESC' do
    assert flunk
  end
  ################################
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

