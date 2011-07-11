require 'test_helper'

class DraftPostsControllerTest < ActionController::TestCase
  setup do
    @draft_post = posts(:draft)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:draft_posts)
  end

  test "should show draft_post" do
    get :show, id: @draft_post.to_param
    assert_response :success
  end

end
