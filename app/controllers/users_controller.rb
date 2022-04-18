class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update]

	def index 
		@users = User.paginate(page: params[:page], per_page: 5)
	end

	def show

	  #pull articles in user profile
	  @articles = @user.articles.paginate(page: params[:page], per_page: 5)
	end
	def new
		@user = User.new
	end
	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			flash[:notice] = "Welcome to the Alpha Blog #{@user.username}, you have successfully signed up"
			redirect_to users_path
		else
			render 'new'
		end
	end

	def edit
	  @user = User.find(params[:id])
	  
	end

	def update
 	  @user = User.find(params[:id])
	  if @user.update(user_params)
	  	flash[:notice] = "Profile successfully updated!"
	  	redirect_to users_path
	  else
	  	render @user
	  end
	end

	private 
	def user_params
		params.require(:user).permit(:username,:email,:password)
	end

	def set_user
	  @user = User.find(params[:id])
	end

end