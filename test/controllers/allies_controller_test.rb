require 'test_helper'

class AlliesControllerTest < ActionController::TestCase
  setup do
    @ally = allies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:allies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ally" do
    assert_difference('Ally.count') do
      post :create, ally: { allies: @ally.allies, userid: @ally.userid }
    end

    assert_redirected_to ally_path(assigns(:ally))
  end

  test "should show ally" do
    get :show, id: @ally
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ally
    assert_response :success
  end

  test "should update ally" do
    patch :update, id: @ally, ally: { allies: @ally.allies, userid: @ally.userid }
    assert_redirected_to ally_path(assigns(:ally))
  end

  test "should destroy ally" do
    assert_difference('Ally.count', -1) do
      delete :destroy, id: @ally
    end

    assert_redirected_to allies_path
  end
end
