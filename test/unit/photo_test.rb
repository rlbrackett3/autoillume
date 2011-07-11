require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  # setup
  ################################
  def setup
    @post = posts :valid
    @section = sections :text
    @photo = photos :valid
  end
  ################################

  # create Text Section object with valid attr
  ################################
  test 'photo: should have valid attr' do
    photo = Photo.new
    # assert post record build in DB
    assert photo
    #assert not valid because title is required
    assert_nil photo.title, "Photo has a body."
    #assert not valid because a section is required
    assert_nil photo.section_id, "Photo has a Section."
    # assert that a valid record cannot be saved
    assert !photo.valid?, "Saved an invalid Photo."

    # Load in valid data
    photo.title = photos(:valid).title
    photo.section_id = sections(:valid).id

    assert photo.valid?

    # check that all values were set correctly with valid data
    assert_equal photo.title, photos(:valid).title
    assert_equal photo.section_id, sections(:valid).id
  end
  ################################

  # respond to attr methods
  ################################
  test 'Photo: should respond to title' do
    assert photos(:valid).title, "Photo does not respond to title."
  end

  test 'Photo: should respond to created_at' do
    assert photos(:valid).created_at, "Photo does not respond to created_at."
  end

  test 'Photo: should respond to updated_at' do
    assert photos(:valid).updated_at, "Photo does not respond to updated_at."
  end

  test 'Photo: should respond to post_id' do
    assert photos(:valid).section_id, "Photo does not respond to section_id."
  end

  test 'Photo: should respond to width' do
    assert photos(:valid).width, "Photo does not respond to width."
  end

  test 'Photo: should respond to height' do
    assert photos(:valid).height, "Photo does not respond to height."
  end

  test 'Photo: should respond to orientation' do
    assert photos(:valid).orientation, "Photo does not respond to orientation."
  end
  ################################

  # title
  ################################
   test 'title: should not be shorter than 3 characters' do
    short_title = "a" * 2
    @photo.title = short_title
    assert !@photo.valid?, "Saved a Section with a short title."
  end

  test 'title: should not be longer than 254 characters' do
    long_title = "a" * 255
    @photo.title = long_title
    assert !@photo.valid?, "Saved a Section with a long title."
  end

  test 'title: should create a valid section with a title' do
    photo = Photo.new title: "foobar"
    photo.section_id = @section.id
    assert photo.save, "Created an invalid Photo with no title."
  end
  ################################

  # image
  ################################
  test 'image: should fail when no image file is assigned' do
    photo = @section.photos.build
    assert !photo.save, "Saved a photo without an image file."
  end

  test 'image: should be success when an image file is assigned' do
    photo = @section.photos.create title: "foobar", image_filename: "test.jpg"
    photo.save
    assert_equal photo.image.current_path, (Rails.public_path + "/uploads/photo/image/#{photo.id}/test.jpg")
  end
  ################################

  # image dimensions and orientation
  ################################
  test 'width: should save image width' do
    stub_magick(640, 480)
    photo = @section.photos.create title: "foobar", image_filename: "test.jpg"
    assert_equal photo.width, 640, "Width not set to 640"
  end

  test 'height: should save image height' do
    stub_magick(640, 480)
    photo = @section.photos.create title: "foobar", image_filename: "test.jpg"
    assert_equal photo.width, 480, "Width not set to 480"
  end

  test 'orientation: should save as landscape' do
    stub_magick(640, 480) #defined this method
    photo = @section.photos.create title: "foobar", image_filename: "test.jpg"
    assert_equal photo.orientation, "landscape", "Orientation not set to landscape."
  end

  test 'orientation: should save as portrait' do
    stub_magick(480, 640)
    photo = @section.photos.create title: "foobar", image_filename: "test.jpg"
    assert_equal photo.orientation, "portrait", "Orientation not set to portrait."
  end
  ################################

  # associations
  ################################
  test 'associated: should not create a valid Photo without a Section' do
    photo = Photo.create title: "foobar", section_id: @section.id
    assert !photo.valid?, "Saved an invalid Photo without a Section."
  end
  ################################

  # tests
  ################################

  ################################
  private

    def stub_magick(width=1280, height=960)
      MiniMagick::Image.stubs(:open).returns(width: width, height: height)
    end

end

# == Schema Information
#
# Table name: photos
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  width       :integer
#  height      :integer
#  orientation :string(255)
#  section_id  :integer
#  created_at  :datetime
#  updated_at  :datetime
#

