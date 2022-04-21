require "test_helper"

class ListCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name: "Sports")
    @category2 = Category.create(name: "Travel")
  end
  #must be links below thats why we use ahrefs
  test "show category listing" do
    get '/categories'
    assert_select "a[href=?]", category_path(@category), test: @category.name
    assert_select "a[href=?]", category_path(@category2), test: @category2.name
  end
end
