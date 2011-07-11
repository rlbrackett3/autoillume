require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
    @post = posts(:valid)
    @admin = admins(:foo)
  end

  # valid post data
  ################################
  test 'check that data is valid' do
    post = Post.new

    # assert post record build in DB
    assert post

    # assert not valid because admin is required
    assert !post.valid?, "Valid post was created without title, body, and admin"

    # load admin from fixtures
    admin_id = admins(:foo).id

    post.title = "Title"
    post.body = "Some body text."
    post.admin_id = admin_id

    assert post.valid?

    # compare equal attr
    assert_equal post.title, "Title"
    assert_equal post.body, "Some body text."
    assert_equal post.admin_id, admin_id
  end
  ################################

  # responding to attrs and methods
  ################################
  test 'should respond to title' do
    assert @post.title, "Post does not respond to title."
  end

  test 'should respond to body' do
    assert @post.body, "Post does not respond to body."
  end

  test 'should respond to created_at' do
    assert @post.created_at, "Post does not respond to created_at."
  end

  test 'should respond to updated_at' do
    assert @post.updated_at, "Post does not respond to updated_at."
  end

  test 'should respond to published_at' do
    post = posts(:published)
    assert post.published_at, "Post does not respond to published_at."
  end

  test 'should respond to id' do
    assert @post.id, "Post does not respond to id."
  end

  test 'should respond to admin association' do
    assert @post.admin_id, "Post does not respond and admin assoc."
  end
  ################################

  # accessible attr
  ################################
  # i am not sure about this stuff
  test 'should have an accessible title attr' do
    !assert_protected_attribute Post, :title
  end

  test 'should have an accessible body attr' do
    !assert_protected_attribute Post, :body
  end
  ################################

  # attr protected
  ################################
  test 'should have a protected id attr' do
    assert_protected_attribute Post, :id
  end

  test 'should have a protected updated_at attr' do
    assert_protected_attribute Post, :created_at
  end

  test 'should have a protected created_at attr' do
    assert_protected_attribute Post, :updated_at
  end
  ################################

  # validations
  test 'should create a valid post' do
    admin = admins(:foo)
    post = Post.create(title: "title", body: "Some text.", admin_id: admin.id)
    assert post, "Failed to create a valid post."
  end

  # title
  ################################
  test 'title: should not create a post without a title' do
    post = Post.new(title: "", body: "foobar")
    assert !post.save, "Created an invalid post with no title."
  end

  test 'title: should not create a post with title longer than 200 characters' do
    long_title = "A" * 201
    post = Post.new(title: long_title, body: "foobar")
    assert !post.save, "Created an invalid post with a long (255char) title."
  end
  ################################

  # body
  ################################
  test 'body: should not create a post without a body' do
    post = Post.new(title: "foo", body: "")
    assert !post.save, "Created an invalid post with no body."
  end
  ################################

  # publsihed_at
  ################################
  test 'published_at: should accept valid datetime for published_at' do
    assert flunk
  end

  test 'published_at: should not accept invalid datetime for published_at' do
    assert flunk
  end
  ################################

  # states
  ################################
  test 'state: should have a default state of "initial"' do
    # post = Post.create(title: 'foo', body: 'bar', admin_id: @admin.id)
    assert_equal @post.state, "initial", "Create post without a state."
  end

  test 'state: should not accept undefined states' do
    @post.state = "invalid_state"
    assert !@post.save, "Updated a post with invalid state"
  end

  test 'state: should accept valid states' do
    @post.state = "published"
    assert @post.save, "Unable to updated a post with 'published' state"

    @post.state = "draft"
    assert @post.save, "Unable to updated a post with 'draft' state"
  end
  ################################

  # associations
  ################################
  test 'associated: should not save valid post without an admin.' do
    post = Post.create(title: "foo", body: "bar")
    assert !post.valid?, "Saved post without a valid admin."
  end
  ################################

  # scopes
  ################################
  test 'draft scope: should respond to .drafts scope' do
    assert_respond_to Post, :drafts, "Did not respond to the drafts scope."
  end

  test 'drafts scope: should include draft posts' do
    draft_post = posts(:draft)
    assert_includes Post.drafts, draft_post, "Does not contain the draft post."
  end

  test 'published scope: should respond to .;published scope' do
    assert_respond_to Post, :published, "Did not respond to the published scope."
  end

  test 'published scope: should include published posts' do
    published_post = posts(:published)
    assert_includes Post.published, published_post, "Does not contain the published post."
  end

  ################################


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

