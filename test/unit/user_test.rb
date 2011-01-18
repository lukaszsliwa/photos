require 'test_helper'
require 'ostruct'

class UserTest < ActiveSupport::TestCase
  test "owner?" do
    user = users(:one)
    object_user_id = OpenStruct.new :user_id => user.id
    object_non_user_id = OpenStruct.new :test => true
    object_incorrect_user_id = OpenStruct.new :user_id => user.id+1
    assert user.owner?(object_user_id)
    assert !user.owner?(object_non_user_id)
    assert !user.owner?(object_incorrect_user_id)
  end

  test "user photos" do
    user = users(:one)
    photo = user.photos.create(:file => File.open(File.join(File.dirname(__FILE__), "images/test.png")))
    assert !photo.new_record?
    assert !user.photos.empty?
  end
end
