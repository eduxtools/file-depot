require 'test_helper'

class ImagesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create images" do
    assert_difference('Images.count') do
      post :create, :images => { }
    end

    assert_redirected_to images_path(assigns(:images))
  end

  test "should show images" do
    get :show, :id => images(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => images(:one).to_param
    assert_response :success
  end

  test "should update images" do
    put :update, :id => images(:one).to_param, :images => { }
    assert_redirected_to images_path(assigns(:images))
  end

  test "should destroy images" do
    assert_difference('Images.count', -1) do
      delete :destroy, :id => images(:one).to_param
    end

    assert_redirected_to images_path
  end
end
