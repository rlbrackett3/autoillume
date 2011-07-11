require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  # setup
  ################################
  def setup
    @post = posts :valid
    @text_section = sections :text
    # @photo_section = sections :photo
  end
  ################################

  # create Text Section object with valid attr
  ################################
  test 'text_section: should have valid attr' do
    section = Section.new
    # assert post record build in DB
    assert section
    #assert not valid because body is required
    assert_nil section.body, "Section has a body."
    #assert not valid because a position is required
    section.position = nil
    assert_nil section.position, "Section has a position."
    #assert not valid because a admin is required
    assert_nil section.post_id, "Section has a Post."
    # assert that a valid record cannot be saved
    assert !section.valid?, "Saved an invalid Section."

    # Load in valid data
    section.body = sections(:text).body
    section.position = sections(:text).position
    section.post_id = posts(:valid).id

    assert section.valid?

    # check that all values were set correctly with valid data
    assert_equal section.body, sections(:text).body
    assert_equal section.position, sections(:text).position
    assert_equal section.post_id, posts(:valid).id
  end
  ################################

  # respond to attr methods
  ################################
  test 'section: should respond to body' do
    assert sections(:text).body, "Section does not respond to body."
  end

  test 'section: should respond to position' do
    assert sections(:text).position, "Section does not respond to position."
  end

  test 'should respond to created_at' do
    assert sections(:text).created_at, "Section does not respond to created_at."
  end

  test 'should respond to updated_at' do
    assert sections(:text).updated_at, "Section does not respond to updated_at."
  end

  test 'should respond to post_id' do
    assert sections(:text).post_id, "Section does not respond to post_id."
  end
  ################################

  # body
  ################################
  # test 'body: should not create an invalid section without a body' do
  #   section = Section.new(body: "", post_id: @post.id)
  #   assert !section.save, "Created an invalid post with no body."
  # end

  test 'body: should not be shorter than 3 characters' do
    short_body = "a" * 2
    @text_section.body = short_body

    assert !@text_section.valid?, "Saved a Section with a short body."
  end

  test 'body: should not be longer than 4096 characters' do
    long_body = "a" * 4097
    @text_section.body = long_body

    assert !@text_section.valid?, "Saved a Section with a long body."
  end

  test 'body: should create a valid section with a body' do
    section = Section.new body: "foobar"
    section.post_id = @post.id
    assert section.save, "Created an invalid Section with no body."
  end
  ################################

  # position
  ################################
  test 'position: should create a valid post with position 0' do
    section = Section.create body: "foobar"
    section.post_id = @post.id
    assert section.save, "Failed to create a valid post with position 0."
  end

  test 'position: should create a valid post with position X' do
    section = Section.create body: "foobar", position: 33
    section.post_id = @post.id
    assert section.save, "Failed to create a valid post with position 33."
  end

  test 'position: should not create an invalid post without a position' do
    section = Section.create body: "foobar", position: nil
    section.post_id = @post.id
    assert !section.save, "Saved and invalid post without a position."
  end
  ################################

  # associations
  ################################
  test 'associated: should not create a valid Section without a Post' do
    section = Section.create body: "foobar", post_id: @post.id
    assert !section.valid?, "Saved an invalid Section without a Post."
  end
  ################################

  # photos
  ################################

  ################################

  # scopes
  ################################
  test 'scope_forward: should respond to "forward" scope' do
    assert_respond_to Section, :forward, "Failed to respond to 'forward' scope"
  end

  test 'scope_forward: should order sections by position' do
    post = posts :valid

    s1 = post.sections.create body: "barfoo", position: 1
    s0 = post.sections.create body: "foobar"
    s2 = post.sections.create body: "foofoo", position: 2

    assert_equal Section.forward.first, s0, "Section with position 0 is not first."
    assert_equal Section.forward.last, s2, "Section with position 2 is not last."
  end
  ################################

  # tests
  ################################

  ################################

end

# == Schema Information
#
# Table name: sections
#
#  id         :integer         not null, primary key
#  body       :text
#  position   :integer         default(0)
#  post_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

