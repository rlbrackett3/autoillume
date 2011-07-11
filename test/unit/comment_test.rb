require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  def setup
    @comment = comments(:valid)
  end

  ################################
  test 'should have valid attr' do
    comment = Comment.new
    # assert post record build in DB
    assert comment
    # assert not valid because email is required
    assert_nil comment.email, "Comment has an email address."
    #assert not valid because name is required
    assert_nil comment.name, "Comment has a name."
    #assert not valid because body is required
    assert_nil comment.body, "Comment has a body."
    #assert not valid because a post is required
    assert_nil comment.post_id, "Comment has a post."
    # assert that a valid record cannot be saved
    assert !comment.valid?, "Saved an invalid comment."

    # Load in valid data
    comment.name = comments(:valid).name
    comment.email = comments(:valid).email
    comment.body = comments(:valid).body
    comment.post_id = posts(:valid).id

    assert comment.valid?

    # check that all values were set correctly with valid data
    assert_equal comment.name, comments(:valid).name
    assert_equal comment.email, comments(:valid).email
    assert_equal comment.body, comments(:valid).body
    assert_equal comment.post_id, posts(:valid).id

  end
  ################################

  # Responding to attr and methods
  ################################
  test 'should respond to name' do
    assert @comment.name, "Comment does not respond to name."
  end

  test 'should respond to email' do
    assert @comment.email, "Comment does not resond to email."
  end

  test 'should respond to url' do
    assert @comment.url, "Comment does not respond to url."
  end

  test 'should respond to body' do
    assert @comment.body, "Comment does not respond to body."
  end

  test 'should respond to created_at' do
    assert @comment.created_at, "Comment does not respond to created_at."
  end

  test 'should respond to updated_at' do
    assert @comment.updated_at, "Comment does not respond to updated_at."
  end

  test 'should respond to id' do
    assert @comment.id, "Comment does not respond to id."
  end

  test 'should respond to post_id' do
    assert @comment.post_id, "Comment does not respond to post_id."
  end

  test 'should respond to state' do
    assert @comment.state, "Comment does not respond to state"
  end
  ################################

  # attr data validations
  # name
  ################################
  test 'name: should be shorter than 3 characters' do
    short_name = "a" * 2
    @comment.name = short_name

    assert !@comment.valid?, "Saved a comment with a short name."
  end

  test 'name: should not be longer than 60 characters' do
    long_name = "a" * 61
    @comment.name = long_name

    assert !@comment.valid?, "Saved a comment with a long name."
  end

  test 'name: should not contain invalid characters' do
    invalid_chars = %w[  ! @ # $ % ^ & * ( ) + = - . , / \ | < > * ~ ` " ' : ; ' [ ] ]
    invalid_chars.each do |char|
      @comment.name = "name_" + char
      assert !@comment.valid?, "Created a comment with an invalid char in name."
    end
  end
  ################################

  # email
  ################################
  test 'email: should be shorter than 5 characters' do
    short_email = "a" * 4
    @comment.email = short_email

    assert !@comment.valid?, "Saved a comment with a short email."
  end

  test 'email: should not be longer than 120 characters' do
    long_email = "a" * 121
    @comment.email = long_email

    assert !@comment.valid?, "Saved a comment with a long email."
  end

  test 'email: should reject invalid emails' do
    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    invalid_emails = %w[user@foo,com user_at_foo.org example.user@foo user.com user@foocom user@foo]
    invalid_emails.each do |email|
      @comment.email = email
      assert !@comment.valid?, "Created a comment with an invalid email."
    end
  end
  ################################

  # body
  ################################
  test 'body: should be shorter than 3 characters' do
    short_body = "a" * 2
    @comment.body = short_body

    assert !@comment.valid?, "Saved a comment with a short body."
  end

  test 'body: should not be longer than 1024 characters' do
    long_body = "a" * 1025
    @comment.body = long_body

    assert !@comment.valid?, "Saved a comment with a long body."
  end
  ################################

  # url
  ################################
  test 'url: should be shorter than 9 characters' do
    short_url = "a" * 8
    @comment.url = short_url

    assert !@comment.valid?, "Saved a comment with a short url."
  end

  test 'url: should not be longer than 254 characters' do
    long_url = "a" * 255
    @comment.url = long_url

    assert !@comment.valid?, "Saved a comment with a long url."
  end

  test 'url: should allow a blank url' do
    @comment.url = ""
    assert @comment.valid?, "Unable to save comment without a url"
  end
  ################################

  # state
  ################################
  test 'state: should be set to "unapproved" on create' do
    c = Comment.new
    assert_equal c.state, "unapproved", "Failed to set initial state."
  end

  test 'state: should transition to "approved"' do
    @comment.state = "approved"
    assert_equal @comment.state, "approved", "Unable to transition state to 'approved'"
  end

  test 'state: should not accept an invalid state' do
    c = comments(:approved)
    c.state = "invalid_state"
    assert !c.valid?, "Changed state to an invaild state."
  end

  # test 'state should not transition to "unapproved"' do
  #   c = comments(:approved)
  #   c.state = "unapproved"
  #   c.save
  #   # assert_not_equal c.state, "unapproved", "Transitioned state from approved to unapproved."
  #   assert_equal c.state, "approved", "State changed from approved."
  # end
  ################################

  # associations
  ################################
  test 'associated: should not save valid comment without a post.' do
    comment = Comment.create name: "foo", email: "foo@bar.com", body: "foobar"
    assert !comment.valid?, "Saved invalid comment without a post."
  end
  ################################

  # scopes
  ################################
  test 'default scope should be order created_at DESC' do
    assert flunk
  end

  test 'should respond to .unapproved scope' do
    assert_respond_to Comment, :unapproved, "Did not respond to the unapproved scope."
  end

  test 'unapproved scope should include unapproved comments' do
    unapproved_comment = comments :valid
    assert_includes Comment.unapproved, unapproved_comment, "Does not contain the unapproved comment."
  end

  test 'should respond to .approved scope' do
    assert_respond_to Comment, :approved, "Did not respond to the approved scope."
  end

  test 'approved scope should include approved comments' do
    approved_comment = comments :approved
    assert_includes Comment.approved, approved_comment, "Does not contain the approved comment."
  end
  ################################

end


# == Schema Information
#
# Table name: comments
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  url        :string(255)
#  body       :text
#  post_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  state      :string(255)
#

