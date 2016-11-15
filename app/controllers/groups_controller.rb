class GroupsController < ApplicationController

	helper_method :find_group

	
	def add_chef
		@group = Group.find(params[:group_id])
		User.where(chef: @group.id)
		User.update(chef: 0)
		@user = User.find(params[:user_id])
		@user.update(chef: @group.id)
		redirect_to group_path(@group)
	end


	def add_group
		@user = User.find(params[:user_id])
		@group = Group.find(params[:group_id])

		@user.group = @group

		@user.update(group_id: @group.id)
		redirect_to group_path(@group)
	end

	def dell_user
		@user = User.find(params[:user_id])
		@group = Group.find(params[:group_id])

		@user.update(group_id: 0 )
		redirect_to group_path(@group)
	end








	def index
		@group 	= GroupDecorator.decorate_collection(Group.all)
	end

	def new
		@group = Group.new
	end

	def create
		@group = Group.new(group_param)
		if @group.save
			redirect_to groups_path
		else
			render :new
		end
	end

	def edit
		find_group
	end

	def show
		@group 	= find_group.decorate
		@user 	= find_group.users.all
		@tasc 	= find_group.tascs.all.order("id DESC").limit(3)
		@chef	= User.where(chef: @group.id)
		@user_all = User.all

	end


	def update
		if find_group.update(group_param)
			redirect_to group_path
		else
			render :edit
		end
	end


	def destroy
		if find_group.destroy
			redirect_to groups_path
		else
			redirect_to groups_path
		end
	end

	private
		def find_group
			@group ||= Group.find(params[:id]) 
		end
		def group_param
			params[:group].permit(:group_name,:user_id)
		end

end