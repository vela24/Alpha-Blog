require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
	# setup instance variable
	def setup
		@category = Category.new(name: "Sports")
	end
	# come up with feature of definition of your test
	test "category should be valid" do 
		assert @category.valid?
	end

	test "name should be present" do
		@category = Category.new(name: " ")
		assert_not @category.valid?
	end

	test "name should be unique" do
		@category.save
		@category2 = Category.new(name: "Sports")
		assert_not @category2.valid?

	end

	test "name should not be too long" do

		@category.name = "a" * 26
		assert_not @category.valid?
	end

	test "name should not be too short" do
		@category.name = "aa"
		assert_not @category.valid?
	end

end