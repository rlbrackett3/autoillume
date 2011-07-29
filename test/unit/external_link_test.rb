require 'test_helper'

class ExternalLinkTest < ActiveSupport::TestCase
require 'test_helper'

  def setup
    @external_link = ExternalLink.create(title: 'foo', url: 'bar', description: 'foobar')
  end

  test 'should create a new external_link with valid attr' do
    assert @external_link
  end

  test 'should create a new external_link with valid attr' do
     external_link = ExternalLink.new(title: 'bar', url: 'foo', description: 'foobar')
    assert external_link.save
  end

  # testing for validations
  test 'should not create a new external_link with no attr' do
    external_link = ExternalLink.new
    assert !external_link.save, "Saved the external_link with no attr"
  end

  test 'should not create a new external_link with non unique title' do
    #external_link = external_link.create(title: 'test', url: 'foo')
    external_link2 = ExternalLink.new(title: 'foo', url: 'foo')
    assert !external_link2.save, "Saved the external_link with duplicate title"
  end

  test 'should not create a new external_link with non unique url' do
    #external_link = external_link.create(title: 'foo', url: 'foo')
    external_link2 = ExternalLink.new(title: 'bar', url: 'bar')
    assert !external_link2.save, "Saved the external_link with duplicate url"
  end

  test 'should require presence of title' do
    external_link = ExternalLink.new(url: 'foo')
    assert !external_link.save, "Saved the external_link without a title"
  end

  test 'should require presence of url' do
    external_link = ExternalLink.create(title: 'foo')
    assert !external_link.save, "saved the external_link without a url"
  end

  # testing for accessible and protected attr
  # accessible attr
  test 'title should be accessible' do
    !assert_protected_attribute ExternalLink, :title
  end

  test 'url should be accessible' do
    !assert_protected_attribute ExternalLink, :url
  end

  test 'description should be accessible' do
    !assert_protected_attribute ExternalLink, :description
  end

  # I can probably remove these, but they seem to work for now
  test 'should make title attr accessible' do
    @external_link.title = "title"
    @external_link.save
    assert_equal @external_link.title, "title", "Unable to change title"
  end

  test 'should have url attr accessible' do
    @external_link.url = "url"
    @external_link.save
    assert_equal @external_link.url, "url", "Unable to change url"
  end

  test 'should have description attr accessible' do
    @external_link.description = "description"
    @external_link.save
    assert_equal @external_link.description, "description", "Unable to change description"
  end

  # protected attr
  test 'should protect created_at' do
    assert_protected_attribute ExternalLink, :created_at
  end

  test 'should protect updated_at' do
    assert_protected_attribute ExternalLink, :updated_at
  end

  test 'should protect id' do
    assert_protected_attribute ExternalLink, :id
  end

  # for use with ranked_model
  test 'should respond to link_order' do
    assert @external_link.link_order, "Failed to respond to link_order attr."
  end

  test 'should assign 0 as default external_link_order position' do
    external_link = ExternalLink.new(@external_link.attributes)
    assert_equal external_link.external_link_order, 0, "Failed to set default external_link_order to 0."
  end
end
