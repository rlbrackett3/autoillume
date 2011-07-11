require 'test_helper'

# Things to include
# was the web request successful?
# was the user redirected to the right page?
# was the user successfully authenticated?
# was the correct object stored in the response template?
# was the appropriate message displayed to the user in the view?

class SessionsControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Admin.stubs(:authenticate).returns(nil)
    post :create
    assert_template 'new'
    assert_nil session['admin_id']
  end

  def test_create_valid
    Admin.stubs(:authenticate).returns(Admin.first)
    post :create
    assert_redirected_to root_url
    assert_equal Admin.first.id, session['admin_id']
  end
end
