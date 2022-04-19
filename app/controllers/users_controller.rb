class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]
	before_action :require_user, only: [:edit, :update]
	before_action :require_same_user, only: [:edit, :update, :destroy]

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

	def edit
	  
	end

	def update
 	  
	  if @user.update(user_params)
	  	flash[:notice] = "Profile successfully updated!"
	  	redirect_to users_path
	  else
	  	render @user
	  end
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

	def destroy
	  if @user.destroy
	    # must add session user id to nil so session does not point to deleted user
	    session[:user_id] = nil
	    flash[:notice] = " Account successfully deleted"
	    redirect_to articles_path
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
	def require_same_user
	  if current_user != @user
	  	flash[:alert] = "You can only edit your account"
	  	redirect_to @users
	  end
	end

end