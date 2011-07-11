require 'test_helper'

class PageTest < ActiveSupport::TestCase
  def setup
    @page = Page.create(title: 'foo', permalink: 'bar', content: 'foobar')
  end

  test 'should create a new page with valid attr' do
    assert @page
  end

  test 'should save a new page with valid attr' do
     page = Page.new(title: 'bar', permalink: 'foo', content: 'foobar')
    assert page.save
  end

  # testing for validations
  test 'should not save a new page with no attr' do
    page = Page.new
    assert !page.save, "Saved the page without no attr"
  end

  test 'should not save new page with non unique title' do
    #page = Page.create(title: 'test', permalink: 'foo')
    page2 = Page.new(title: 'foo', permalink: 'foo')
    assert !page2.save, "Saved the page with duplicate title"
  end

  test 'should not save new page with non unique permalink' do
    #page = Page.create(title: 'foo', permalink: 'foo')
    page2 = Page.new(title: 'bar', permalink: 'bar')
    assert !page2.save, "Saved the page with duplicate permalink"
  end

  test 'should require presence of title' do
    page = Page.new(permalink: 'foo')
    assert !page.save, "Saved the page without a title"
  end

  test 'should require presence of permalink' do
    page = Page.create(title: 'foo')
    assert !page.save, "saved the page without a permalink"
  end

  # testing for accessible and protected attr
  # accessible attr
  test 'title should be accessible' do
    !assert_protected_attribute Page, :title
  end

  test 'permalink should be accessible' do
    !assert_protected_attribute Page, :permalink
  end

  test 'content should be accessible' do
    !assert_protected_attribute Page, :content
  end

  # I can probably remove these, but they seem to work for now
  test 'should make title attr accessible' do
    @page.title = "title"
    @page.save
    assert_equal @page.title, "title", "Unable to change title"
  end

  test 'should have permalink attr accessible' do
    @page.permalink = "permalink"
    @page.save
    assert_equal @page.permalink, "permalink", "Unable to change permalink"
  end

  test 'should have content attr accessible' do
    @page.content = "content"
    @page.save
    assert_equal @page.content, "content", "Unable to change content"
  end

  # protected attr
  test 'should protect created_at' do
    assert_protected_attribute Page, :created_at
  end

  test 'should protect updated_at' do
    assert_protected_attribute Page, :updated_at
  end

  test 'should protect id' do
    assert_protected_attribute Page, :id
  end

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

