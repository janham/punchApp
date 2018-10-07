require 'test_helper'

class PunchesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get punches_index_url
    assert_response :success
  end

  test "should get show" do
    get punches_show_url
    assert_response :success
  end

  test "should get create" do
    get punches_create_url
    assert_response :success
  end

  test "should get edit" do
    get punches_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get punches_destroy_url
    assert_response :success
  end

end
