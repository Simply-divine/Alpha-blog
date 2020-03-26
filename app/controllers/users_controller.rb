class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update]
	before_action :require_user, only: [:edit,:update,:destroy]
	before_action :require_same_user, only: [:edit, :update, :destroy]
	before_action :require_admin, only: [:destroy]
	def new
		@user = User.new	
	end

	def show
		@user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
		@articles = Article.paginate(page: params[:page], per_page: 5)
	end

	def create
		@user = User.new(user_params)
		if @user.save
			#do something
			session[:user_id] = @user.id
			flash[:success] = "User created successfully"
			redirect_to user_path(@user)
		else
			render 'new'
		end
	end
	
	def index
		@users = User.paginate(page: params[:page], per_page: 5)
	end

	def edit
		
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		flash[:danger] = "User and all articles created by users have been destroyed"
		redirect_to users_path 
	end

	def update
		if @user.update(user_params)
			##update successfull
			flash[:success] = "User updated successfully"
			redirect_to articles_path
		else 
			render 'edit'
		end	
	end

	private
		def user_params
			params.require(:user).permit(:username,:password,:email)
		end
		def set_user
			@user = User.find(params[:id])
		end
		def require_same_user 
			if current_user != @user and !current_user.admin?
				flash[:danger] = "You cannot edit any other person's accounts! "
				redirect_to users_path
			end
		end
		def require_admin
			if logged_in? and !current_user.admin? 
				flash[:danger] = "Only admin can perform this action"
				redirect_to users_path
			end
		end

end