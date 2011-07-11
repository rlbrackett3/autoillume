require 'test_helper'

# Things to include
# was the web request successful?
# was the user redirected to the right page?
# was the user successfully authenticated?
# was the correct object stored in the response template?
# was the appropriate message displayed to the user in the view?

class PagesControllerTest < ActionController::TestCase
  setup do
    @page = pages(:about)
  end

  test "should get index" do
    login_admin
    get :index
    assert_response :success
    assert_not_nil assigns(:pages)
  end

  test "should get new" do
    login_admin
    get :new
    assert_response :success
  end

  test "should create page" do
    login_admin
    assert_difference('Page.count') do
      post :create, page: { title:  "foo", permalink: "bar", content: "foobar" }
    end

    assert_redirected_to page_path(assigns(:page))
  end

  test "should show page" do
    get :show, id: @page.to_param
    assert_response :success
  end

  test "should get edit" do
    login_admin
    get :edit, id: @page.to_param
    assert_response :success
  end

  test "should update page" do
    login_admin
    put :update, id: @page.to_param, page: @page.attributes
    assert_redirected_to page_path(assigns(:page))
  end

  test "should destroy page" do
    login_admin
    assert_difference('Page.count', -1) do
      delete :destroy, id: @page.to_param
    end

    assert_redirected_to pages_path
  end
end
