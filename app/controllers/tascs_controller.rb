class TascsController < ApplicationController

	helper_method :find_tasc, :find_who

	def index

		if params[:user_id] 

			if find_user == current_user || current_user.admin == 1
				@tasc = find_user.tascs.where(params[:user_id]).order("id DESC")
			else
				redirect_to user_path(find_user)
			end

		else
			if current_user.admin == 1 || current_user.group_id == find_group.id 
				@tasc = find_group.tascs.all.order("id DESC")
			else
				redirect_to group_path(find_group)
			end
		end

	end


	def new
		@tasc = Tasc.new
	end


	def create
		if params[:user_id]	
			p find_user	
			p @tasc = find_user.tascs.create(tasc_param)	 
			if @tasc.save
				redirect_to user_path(find_user)
				TaskMailer.task_created(@tasc).deliver_later
			else
				render :new
				puts "in user"
			end

		else
			@tasc = find_group.tascs.create(tasc_param) 
			if @tasc.save
				redirect_to group_path(find_group)
				TaskMailer.task_created_group(@tasc, find_group).deliver_later
			else
				render :new
			end
		end
	end

	def edit
		find_tasc
	end

	def update
		if find_tasc.update(tasc_param)
			redirect_to user_tascs_path
		else
			render :edit
		end
	end

	def destroy
		if params[:group_id]
			@group = find_tasc.group
			if find_tasc.destroy
				redirect_to group_tascs_path(@group)
			else
				redirect_to group_tascs_path(@group)
			end
		else
			@user = find_tasc.user
			if find_tasc.destroy
				redirect_to user_tascs_path(@user)  
			else
				redirect_to user_tascs_path(@user)
			end
		end
	end

	private
		def tasc_param
			params[:tasc].permit(:task_name, :text, :group_id, :user_id)
		end

		def find_user
			@user ||= User.find(params[:user_id])
		end

		def find_group
			@group ||= Group.find(params[:group_id])
		end


		def find_tasc
			@tasc ||= Tasc.find(params[:id])
		end


		def find_who
			@tasc ||= if params[:user_id]						
				find_user 
			else
				find_group
			end
		end
end