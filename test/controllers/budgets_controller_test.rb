require "test_helper"

class BudgetsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers  # Incluye helpers de Devise para simular el inicio de sesión

  setup do
    @user = users(:staff)  # Ajusta según tu modelo de usuario
    sign_in @user  # Simula el inicio de sesión del usuario
  end

  test 'render budget list per user' do 
    get budgets_path(user_id: @user.id)
    
    assert_response :success
  end


  test 'filter budget by most recent' do
    get budgets_path(filter: "Mas recientes")

    assert_response :success
  end
  

  test 'filter budget by oldest' do
    get budgets_path(filter: "Mas antiguos")

    assert_response :success
  end


  test 'filter budget by highest price' do
    get budgets_path(filter: "Mayor precio")

    assert_response :success
  end


  test 'filter budget by lowest price' do
    get budgets_path(filter: "Menor precio")

    assert_response :success
  end


  test 'go to the edit budget page' do
    get edit_budget_path(budgets(:presupuesto1))

    assert_response :success
  end


  test 'Edit budget by name' do
    patch budget_path(budgets(:presupuesto1)), params: {
      budget: {
        name: "Presupuesto modificado"
      }
    }

    assert_redirected_to budgets_path
    assert_equal flash[:notice], 'Presupuesto actualizado correctamente.'
  end


  test 'Edit budget by expiration date' do
    patch budget_path(budgets(:presupuesto1)), params: {
      budget: {
        expiration_date: Date.parse("2024-01-01")
      }
    }

    assert_redirected_to budgets_path
    assert_equal flash[:notice], 'Presupuesto actualizado correctamente.'
  end


  test 'Delete a budget' do
    # Crea un presupuesto para ser eliminado
    budget = Budget.create(name: 'Test Budget', total: 5000, user_id: @user.id)

    assert_difference("Budget.count", -1) do
      delete budget_path(budget)
    end

    assert_equal 2, Budget.count

  
    assert_redirected_to budgets_path
    assert_equal flash[:notice], 'Presupuesto eliminado exitosamente.'
  end

end
