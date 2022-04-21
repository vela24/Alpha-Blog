require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = User.create(username: "johndoe", email: "johndoes@example.com", password: "johndoe123", admin: true)
    sign_in_as(@admin_user)
  end

  test "Get new category form and create category" do
    
    get "/categories/new"
    assert_response :success
    # if invalid submission then there should be no difference in submission count.
    # test database is different from development database so it only takes into account what we put in test
    assert_no_difference 'Category.count', 1 do
      post categories_path, params: { category: {name: " "} }
    end
    # search for word "errors" inside response body which is dialogue error msg prints out
    assert_match "errors", response.body 

    # allows you to search for different elements of the page
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end
end
