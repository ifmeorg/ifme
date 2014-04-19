require 'test_helper'

class MoodsControllerTest < ActionController::TestCase
  setup do
    @mood = moods(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:moods)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mood" do
    assert_difference('Mood.count') do
      post :create, mood: { description: @mood.description, name: @mood.name }
    end

    assert_redirected_to mood_path(assigns(:mood))
  end

  test "should show mood" do
    get :show, id: @mood
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mood
    assert_response :success
  end

  test "should update mood" do
    patch :update, id: @mood, mood: { description: @mood.description, name: @mood.name }
    assert_redirected_to mood_path(assigns(:mood))
  end

  test "should destroy mood" do
    assert_difference('Mood.count', -1) do
      delete :destroy, id: @mood
    end

    assert_redirected_to moods_path
  end
end
