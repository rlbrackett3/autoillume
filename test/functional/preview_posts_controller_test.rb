require 'test_helper'

class PreviewPostsControllerTest < ActionController::TestCase
  setup do
    @preview_post = preview_posts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:preview_posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create preview_post" do
    assert_difference('PreviewPost.count') do
      post :create, preview_post: @preview_post.attributes
    end

    assert_redirected_to preview_post_path(assigns(:preview_post))
  end

  test "should show preview_post" do
    get :show, id: @preview_post.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @preview_post.to_param
    assert_response :success
  end

  test "should update preview_post" do
    put :update, id: @preview_post.to_param, preview_post: @preview_post.attributes
    assert_redirected_to preview_post_path(assigns(:preview_post))
  end

  test "should destroy preview_post" do
    assert_difference('PreviewPost.count', -1) do
      delete :destroy, id: @preview_post.to_param
    end

    assert_redirected_to preview_posts_path
  end
end
