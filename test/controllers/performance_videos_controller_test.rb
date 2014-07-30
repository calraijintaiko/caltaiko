require 'test_helper'

class PerformanceVideosControllerTest < ActionController::TestCase
  setup do
    @performance_video = performance_videos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:performance_videos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create performance_video" do
    assert_difference('PerformanceVideo.count') do
      post :create, performance_video: { link: @performance_video.link, performance_id: @performance_video.performance_id, title: @performance_video.title }
    end

    assert_redirected_to performance_video_path(assigns(:performance_video))
  end

  test "should show performance_video" do
    get :show, id: @performance_video
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @performance_video
    assert_response :success
  end

  test "should update performance_video" do
    patch :update, id: @performance_video, performance_video: { link: @performance_video.link, performance_id: @performance_video.performance_id, title: @performance_video.title }
    assert_redirected_to performance_video_path(assigns(:performance_video))
  end

  test "should destroy performance_video" do
    assert_difference('PerformanceVideo.count', -1) do
      delete :destroy, id: @performance_video
    end

    assert_redirected_to performance_videos_path
  end
end
