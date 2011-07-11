require 'test_helper'

# Things to include
# was the web request successful?
# was the user redirected to the right page?
# was the user successfully authenticated?
# was the correct object stored in the response template?
# was the appropriate message displayed to the user in the view?

class PostsControllerTest < ActionController::TestCase
  setup do
    @post = posts(:valid)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    login_admin
    get :new
    assert_response :success
  end

  test "should not create post without admin" do
    login_admin
    assert_no_difference('Post.count') do
      post :create, post: { title: "new post", body: "with a body" }
    end
  end

  test "should create post with valid admin" do
    login_admin
    assert_difference('Post.count') do
      post :create, post: { title: "new post", body: "with a body", admin_id: admins(:foo).id }
    end

    assert_redirected_to post_path(assigns(:post))
  end

  test "should show post" do
    get :show, id: @post.to_param
    assert_response :success
  end

  test "should get edit" do
    login_admin
    get :edit, id: @post.to_param
    assert_response :success
  end

  test "should update post" do
    login_admin
    put :update, id: @post.to_param, post: @post.attributes
    assert_redirected_to post_path(assigns(:post))
  end

  test "should destroy post" do
    login_admin
    assert_difference('Post.count', -1) do
      delete :destroy, id: @post.to_param
    end

    assert_redirected_to posts_path
  end
end
