require 'test_helper'

class DraftPostsControllerTest < ActionController::TestCase
  setup do
    @draft_post = posts(:draft)
  end

# index action, get
  test "index: should restrict access" do
    get :index
    assert_redirected_to login_path
  end

  test "index: should get index" do
    login_admin
    get :index
    assert_response :success
    assert_not_nil assigns(:draft_posts)
  end

#show action, get
  test "show: should restrict access" do
    get :show, id: 1
    assert_redirected_to login_path
  end

  test "show: should show draft_post" do
    login_admin
    get :show, id: @draft_post.to_param
    assert_response :success
  end

end
