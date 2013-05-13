class MicropostsController < ApplicationController
	before_filter :signed_in_user, only: [:create, :destroy]
	before_filter :correct_user, only: :destroy
	
	def create
		respond_to do |format|
			@micropost = current_user.microposts.build(params[:micropost])
			if @micropost.save
			@feed_items = current_user.home_feed.paginate(page: params[:page])
				format.html do
						flash[:success] = "Micropost created!"
						redirect_to root_path 
				end
				format.js
			else
				format.html do
						@feed_items = current_user.home_feed.paginate(page: params[:page])
						render 'static_pages/home'
				end
				format.js
			end
		end	
	end
	
	def destroy
		@micropost.destroy
		redirect_to root_url
	end
	
	private
		
		def correct_user
			@micropost = current_user.microposts.find_by_id(params[:id])
			redirect_to root_url if @micropost.nil?
		end
	
end