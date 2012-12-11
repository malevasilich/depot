require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @input_attributes = {
      name: "sam",
      password: "secret",
      password_confirmation: "secret"
    }
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: @input_attributes
    end

    assert_redirected_to users_path
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should not update user without current_password" do
    @input_attributes[:current_password] = 'invalid_password'
    put :update, id: @user, user: @input_attributes
    assert_equal assigns(:user).errors.messages[:current_password], ["is not correct"]
  end 

  test "should update user" do
    @input_attributes[:current_password] = 'secret'
    put :update, id: @user, user: @input_attributes
    assert_redirected_to users_path
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
