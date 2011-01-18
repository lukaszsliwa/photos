require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "shouldn't create valid comment object" do
    comment = Comment.new
    assert !comment.save
    assert !comment.errors[:author].empty?
    assert !comment.errors[:content].empty?
    assert !comment.errors[:photo].empty?
  end

  test "shouldn't allow :user attribute in initialize" do
    comment = Comment.new(:author => 'Author', :content => 'Content', :photo => photos(:one))
    assert !comment.save
    assert !comment.errors[:photo].empty?
  end

  test "should create valid comment object" do
    comment = Comment.new(:author => 'Author', :content => 'Content')
    comment.photo = photos(:one)
    assert comment.save
  end

  test "to_s" do
    comment = Comment.new(:content => 'Content')
    assert_equal comment.to_s, comment.content
  end
  
end
