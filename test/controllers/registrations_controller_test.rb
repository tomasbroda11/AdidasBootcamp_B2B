require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers  # Incluye helpers de Devise para simular el inicio de sesión

  setup do
    @user = users(:staff) 
    sign_in @user  # Simula el inicio de sesión del usuario
  end

  
  test 'go to edit profile page' do
    get edit_user_registration_path(users(:staff))

    assert_response :success
  end


  test "Edit user" do
    patch user_registration_path(users(:staff)), params: {
      user: {
        email:"test@testmail.com"
      }
    }

    

    assert_response :ok
    assert_response :success
  end
end
