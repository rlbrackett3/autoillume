require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    @comment = comments(:valid)
    @approved_comment = comments(:approved)
    @post = posts(:valid)
  end

# index action, get
  test "index: should restrict access to logged in admin" do
    get :index
    assert_redirected_to login_path
  end

  test "index: should get index" do
    login_admin
    get :index
    assert_response :success, 'undable to load index action.'

    assert_not_nil assigns(:posts), 'unable to assign posts variable.'
    assert_not_nil assigns(:comments), 'unable to assign comments variable.'
    assert_not_nil assigns(:approved_comments), 'unable to assign approved comments variable.'
    assert_not_nil assigns(:unapproved_comments), 'unable to assign approved comments variable.'
  end

  test "index: should display a list of approved comments by post" do
    login_admin
    get :index
    assert_select 'ul.comments_approved' do
      # assert_select 'li.comment_approved'
    end
  end

  test "index: should display a list of unapproved comments by post" do
    login_admin
    get :index
    assert_select 'ul.comments_unapproved' do
      # assert_select 'li.comment_unapproved'
    end
  end

# show action, get
  test "new: should get new" do
    post = @post
    get :new, post_id: @post.id, post: @post
    assert_response :success
  end

# create action, post
  test "create: should create comment for a post" do
    assert_difference('Comment.count') do
      post :create, post_id: @comment.to_param, comment: @comment.attributes
    end

    assert_redirected_to post_path(@post)
    assert_equal 'Comment was successfully created.', flash[:notice]
  end

# show action, get
  test "show: should show comment for a post" do
    get :show, post_id: @comment.to_param, id: @comment.to_param
    assert_response :success
  end

#edit action, get
  test "edit: should require logged in admin to edit comments" do
    get :edit, post_id: 1, id: 1
    assert_redirected_to login_path
  end

  test "edit: should get edit" do
    login_admin
    post = @post
    get :edit, post_id: @comment.to_param, id: @comment.to_param
    assert_response :success
  end

# update action, put
  test "update: should require logged in admin to update comments" do
    put :update, post_id: 1, id: 1
    assert_redirected_to login_path
  end

  test "update: should update comment" do
    login_admin
    put :update, post_id: @comment.to_param, id: @comment.to_param, comment: @comment.attributes
    assert_redirected_to post_path(@post)
  end

# destroy action, get
  test "destroy: should require logged in admin to destroy comments" do
    get :destroy, post_id: 1, id: 1
    assert_redirected_to login_path
  end

  test "destroy: should destroy comment" do
    login_admin
    assert_difference('Comment.count', -1) do
      delete :destroy, post_id: @comment.to_param, id: @comment.to_param
    end

    assert_redirected_to post_path(assigns(:post_id))
  end

end
