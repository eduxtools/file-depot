require 'test_helper'

class SyllabiControllerTest < ActionController::TestCase
  setup do
    @syllabus = syllabi(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:syllabi)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create syllabus" do
    assert_difference('Syllabus.count') do
      post :create, syllabus: { course_id: @syllabus.course_id, instructor_id: @syllabus.instructor_id, term: @syllabus.term }
    end

    assert_redirected_to syllabus_path(assigns(:syllabus))
  end

  test "should show syllabus" do
    get :show, id: @syllabus
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @syllabus
    assert_response :success
  end

  test "should update syllabus" do
    patch :update, id: @syllabus, syllabus: { course_id: @syllabus.course_id, instructor_id: @syllabus.instructor_id, term: @syllabus.term }
    assert_redirected_to syllabus_path(assigns(:syllabus))
  end

  test "should destroy syllabus" do
    assert_difference('Syllabus.count', -1) do
      delete :destroy, id: @syllabus
    end

    assert_redirected_to syllabi_path
  end
end
