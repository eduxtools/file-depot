require 'test_helper'

class OtherFilesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:other_files)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create other_file" do
    assert_difference('OtherFile.count') do
      post :create, :other_file => { }
    end

    assert_redirected_to other_file_path(assigns(:other_file))
  end

  test "should show other_file" do
    get :show, :id => other_files(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => other_files(:one).to_param
    assert_response :success
  end

  test "should update other_file" do
    put :update, :id => other_files(:one).to_param, :other_file => { }
    assert_redirected_to other_file_path(assigns(:other_file))
  end

  test "should destroy other_file" do
    assert_difference('OtherFile.count', -1) do
      delete :destroy, :id => other_files(:one).to_param
    end

    assert_redirected_to other_files_path
  end
end
