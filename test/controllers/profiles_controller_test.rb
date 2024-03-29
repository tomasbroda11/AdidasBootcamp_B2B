require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers  # Incluye helpers de Devise para simular el inicio de sesión

  setup do
    @user = users(:staff) 
    sign_in @user  # Simula el inicio de sesión del usuario
  end

  test "render user profile" do
    get user_profile_path(@user.id)
    assert_response :success
  end
end
