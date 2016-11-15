class UserController < ApplicationController

	helper_method :find_user

	def profile
		@user = current_user.decorate
		@tasc = find_user.tascs.order("id DESC").limit(3)
	end
	

	def index
		@users = UserDecorator.decorate_collection(User.all)
		 
	end

	def edit
		find_user
	end

	def show
		@user = find_user.decorate
		@tasc 	= find_user.tascs.order("id DESC").limit(3)
		if current_user == find_user
			redirect_to root_path
		end
	end

	def update
		@user = find_user
		@user_all = User.all
		if @user.position_in_company != params[:user][:position_in_company] &&  find_user.update(user_param) 
			redirect_to user_path

			TaskMailer.position_in_company_changed(@user).deliver_later

		elsif find_user.update(user_param)
			redirect_to user_path
		else
			render :edit
		end

	end

	def destroy
		if find_user.destroy
			redirect_to user_index_path
		else
			redirect_to user_index_path
		end
	end



	private
		

		def find_user
			@user ||= User.find(params[:id])
		end

		def user_param
			params[:user].permit(:name_user,:position_in_company,:phone_user,:email,:birthday_user,:about_user,:user_avatar,:user_id,:group_id)
		end

end