require 'test_helper'

# Things to include
# was the web request successful?
# was the user redirected to the right page?
# was the user successfully authenticated?
# was the correct object stored in the response template?
# was the appropriate message displayed to the user in the view?

class AdminsControllerTest < ActionController::TestCase
  # def test_new
  #   get :new
  #   assert_template 'new'
  # end

  # def test_create_invalid
  #   Admin.any_instance.stubs(:valid?).returns(false)
  #   post :create
  #   assert_template 'new'
  # end

  # def test_create_valid
  #   Admin.any_instance.stubs(:valid?).returns(true)
  #   post :create
  #   assert_redirected_to root_url
  #   assert_equal assigns['admin'].id, session['admin_id']
  # end

  def test_edit_without_user
    get :edit, :id => "ignored"
    assert_redirected_to login_url
  end

  def test_edit
    login_admin
    @controller.stubs(:current_admin).returns(Admin.first)
    get :edit, :id => "ignored"
    assert_template 'edit'
  end

  def test_update_without_user
    put :update, :id => "ignored"
    assert_redirected_to login_url
  end

  def test_update_invalid
    login_admin
    @controller.stubs(:current_admin).returns(Admin.first)
    Admin.any_instance.stubs(:valid?).returns(false)
    put :update, :id => "ignored"
    assert_template 'edit'
  end

  def test_update_valid
    login_admin
    @controller.stubs(:current_admin).returns(Admin.first)
    Admin.any_instance.stubs(:valid?).returns(true)
    put :update, :id => "ignored"
    assert_redirected_to root_url
  end
end
