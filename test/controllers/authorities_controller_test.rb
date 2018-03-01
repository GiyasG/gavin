require 'test_helper'

class AuthoritiesControllerTest < ActionController::TestCase
  setup do
    @authority = authorities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:authorities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create authority" do
    assert_difference('Authority.count') do
      post :create, authority: { about: @authority.about, dob: @authority.dob, name: @authority.name, position: @authority.position, sex: @authority.sex, surname: @authority.surname, title: @authority.title }
    end

    assert_redirected_to authority_path(assigns(:authority))
  end

  test "should show authority" do
    get :show, id: @authority
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @authority
    assert_response :success
  end

  test "should update authority" do
    patch :update, id: @authority, authority: { about: @authority.about, dob: @authority.dob, name: @authority.name, position: @authority.position, sex: @authority.sex, surname: @authority.surname, title: @authority.title }
    assert_redirected_to authority_path(assigns(:authority))
  end

  test "should destroy authority" do
    assert_difference('Authority.count', -1) do
      delete :destroy, id: @authority
    end

    assert_redirected_to authorities_path
  end
end
