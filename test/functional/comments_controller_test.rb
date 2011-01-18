require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    @comment = comments(:one)
    @photo = @comment.photo
  end

  test "should get new" do
    get :new, { :photo_id => @photo.to_param }
    assert_response :success
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post :create, { :photo_id => @photo, :comment => @comment.attributes }
    end

    assert_redirected_to photo_path(@photo, :anchor => "comment-#{assigns(:comment).to_param}")
  end

end
