require 'test_helper'

class SyllabusFilesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:syllabus_files)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create syllabus_file" do
    assert_difference('SyllabusFile.count') do
      post :create, :syllabus_file => { }
    end

    assert_redirected_to syllabus_file_path(assigns(:syllabus_file))
  end

  test "should show syllabus_file" do
    get :show, :id => syllabus_files(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => syllabus_files(:one).to_param
    assert_response :success
  end

  test "should update syllabus_file" do
    put :update, :id => syllabus_files(:one).to_param, :syllabus_file => { }
    assert_redirected_to syllabus_file_path(assigns(:syllabus_file))
  end

  test "should destroy syllabus_file" do
    assert_difference('SyllabusFile.count', -1) do
      delete :destroy, :id => syllabus_files(:one).to_param
    end

    assert_redirected_to syllabus_files_path
  end
end
