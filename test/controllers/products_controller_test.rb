require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest

  test 'render a list of porducts through sport category' do
    get products_path(category_id: categories(:sport))

    assert_response :success
  end

  test 'render a list of porducts through footwear category' do 
    get products_path(category_id: categories(:footwear))

    assert_response :success
  end

  test 'render a list of porducts through clothes category' do 
    get products_path(category_id: categories(:clothes))

    assert_response :success
  end

  test 'render a list of porducts through accessories category' do 
    get products_path(category_id: categories(:accessories))

    assert_response :success
  end
end