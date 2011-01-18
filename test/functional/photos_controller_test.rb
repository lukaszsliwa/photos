require 'test_helper'

class PhotosControllerTest < ActionController::TestCase

  setup do
    @photo = photos(:one)
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:photos)
  end

  test "should get new" do
    sign_in @user
    get :new
    assert_response :success
  end

  test "shouldn't get new because of guest" do
    get :new
    assert_redirected_to new_user_session_url
  end

  test "should create photo" do
    sign_in @user
    assert_difference('Photo.count') do
      post :create, :photo => { :file => File.open(File.join(File.dirname(__FILE__), "../unit/images/test.jpg")) }
    end

    assert_response :success
  end

  test "should show photo by guest" do
    get :show, :id => @photo.to_param
    assert_response :success
  end

  test "should show photo by user" do
    sign_in @user
    get :show, :id => @photo.to_param
    assert_response :success
  end

  test "should destroy photo by owner" do
    sign_in @photo.user
    assert_difference('Photo.count', -1) do
      delete :destroy, :id => @photo.to_param
    end

    assert_redirected_to photos_path
  end

  test "shouldn't destroy photo because of owner" do
    sign_in users(:two)
    
    assert_raise ActiveRecord::RecordNotFound do
      assert_difference('Photo.count', 0) do
        delete :destroy, :id => @photo.to_param
      end
    end

    assert_response :success
  end

end
