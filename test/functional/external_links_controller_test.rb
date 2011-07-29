require 'test_helper'

class ExternalLinksControllerTest < ActionController::TestCase
  setup do
    @external_link = external_links(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:external_links)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create external_link" do
    assert_difference('ExternalLink.count') do
      post :create, external_link: @external_link.attributes
    end

    assert_redirected_to external_link_path(assigns(:external_link))
  end

  test "should show external_link" do
    get :show, id: @external_link.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @external_link.to_param
    assert_response :success
  end

  test "should update external_link" do
    put :update, id: @external_link.to_param, external_link: @external_link.attributes
    assert_redirected_to external_link_path(assigns(:external_link))
  end

  test "should destroy external_link" do
    assert_difference('ExternalLink.count', -1) do
      delete :destroy, id: @external_link.to_param
    end

    assert_redirected_to external_links_path
  end
end
