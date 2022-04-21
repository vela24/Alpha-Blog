class CategoriesController < ApplicationController
	before_action :set_category, only: [:show]
	before_action :require_admin, only: [:create, :new]
	def new
		@category = Category.new
	end
	def create
		@category = Category.new(category_params)
		if @category.save
			flash[:notice] = "Category successfuly created"
			redirect_to @category
		else
			render 'new'
		end

	end

	def index
		@categories = Category.paginate(page: params[:page], per_page: 5)
	end

	def show
		@articles = @category.articles.paginate(page: params[:page], per_page: 5)
	end

	private
	def set_category
		@category = Category.find(params[:id])
	end
	def category_params
		params.require(:category).permit(:name)
	end

	def require_admin
		if !(logged_in? &&	current_user.admin)
			flash[:alert] = "Only admins can create Categories"
			redirect_to categories_path
		end
	end

end
