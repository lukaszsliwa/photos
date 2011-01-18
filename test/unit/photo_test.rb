require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  test "shouldn't create valid photo" do
    photo = Photo.new
    assert !photo.valid?
    assert !photo.errors.empty?
    assert !photo.errors[:user].empty?
    assert !photo.errors[:file].empty?
  end

  test "shouldn't allow file type" do
    photo = Photo.new(:file => File.open(__FILE__))
    photo.user = users(:one)
    assert !photo.valid?, photo.errors.inspect
  end
  
  Photo::ALLOW_EXTENSIONS.each do |ext|
    
    test "should create valid object of photo with extension .#{ext}" do
      path = File.join(File.dirname(__FILE__), "images/test.#{ext}")
      photo = Photo.new(:file => File.open(path))
      photo.user = users(:one)
      assert photo.valid?, photo.errors.inspect
    end

  end

  test "shouldn't allow :user attribute in initializer" do
    path = File.join(File.dirname(__FILE__), "images/test.png")
    photo = Photo.new(:file => File.open(path), :user => users(:one))
    assert !photo.valid?
    assert !photo.errors[:user].empty?
  end

  test "should create comment" do
    photo = photos(:one)
    comment = photo.comments.create(comments(:one).attributes)
    assert !comment.new_record?
  end
end
