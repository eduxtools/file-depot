require 'test_helper'

class StudentsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:students)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create students" do
    assert_difference('Students.count') do
      post :create, :students => { }
    end

    assert_redirected_to students_path(assigns(:students))
  end

  test "should show students" do
    get :show, :id => students(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => students(:one).to_param
    assert_response :success
  end

  test "should update students" do
    put :update, :id => students(:one).to_param, :students => { }
    assert_redirected_to students_path(assigns(:students))
  end

  test "should destroy students" do
    assert_difference('Students.count', -1) do
      delete :destroy, :id => students(:one).to_param
    end

    assert_redirected_to students_path
  end
end
