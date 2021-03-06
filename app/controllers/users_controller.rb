class UsersController < ApplicationController
	before_filter :signed_in_user, 	only: [:index, :edit, :update, :destroy, :following, :followers]
	before_filter :signed_out_user, only: [:new, :create]
	before_filter :correct_user, 	only: [:edit, :update]
	before_filter :admin_user,		only: :destroy

  def show
  	@user = User.find(params[:id])
  	@microposts = @user.microposts.paginate(page: params[:page])
 	@feed_items = @user.feed.paginate(page: params[:page]) if signed_in?
  end
  
  def new
  	@user = User.new
  end
  
  def create
  	@user = User.new(params[:user])
  	if @user.save
  		sign_in @user
  		flash[:success] = "Welcome to the Sample App!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end
  
  def destroy
  	User.find(params[:id]).destroy
  	flash[:success] = "User destroyed."
  	redirect_to users_url
  end
  
  def edit
  end
  
  def following
  	@title = "Following"
  	@user = User.find(params[:id])
  	@users = @user.followed_users.paginate(page: params[:page])
  	render 'show_follow'
  end
  
  def followers
  	@title = "Followers"
  	@user = User.find(params[:id])
  	@users = @user.followers.paginate(page: params[:page])
  	render 'show_follow'
  end
  
  def update
  	@user = User.find(params[:id])
  	
  	respond_to do |format|
  		if @user.update_attributes(params[:user])
  			sign_in @user
  			format.html do
  				flash[:success] = "Profile updated" 
  				redirect_to @user 
  			end
  			format.js
  		else
  			format.html { render 'edit' }
  			format.js 
  		end
  	end
  end
  
  def index
  	@users = User.paginate(page: params[:page])
  end
  
  private
  	
  	def signed_out_user
  		unless !signed_in?
  			redirect_to(root_path)
  		end
  	end
  	
  	def correct_user
  		@user = User.find(params[:id])
  		redirect_to(root_path) unless current_user?(@user)
  	end
  	
  	def admin_user
  		@user = User.find(params[:id])
  		redirect_to(root_path) unless current_user.admin? && !current_user?(@user)
  	end
end
