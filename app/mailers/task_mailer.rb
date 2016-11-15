class TaskMailer < ActionMailer::Base

	default from: "info@mycrm.localhost",
			template_path: 'mailers/task'

	def task_created(tasc)
		@tasc = tasc
		mail 	to: @tasc.user.email,
				subject: "Создана новая задача"
	end

	def task_created_group(tasc, group)
		@tasc = tasc
		group = group.users.all
		mail 	to: group.collect(&:email),
				subject: "Новая задача для отдела"
	end

	def position_in_company_changed(user)
		user_all = User.all
		@user = user
			mail 	to:  user_all.collect(&:email),
					subject: "Изменения в компании"
	end

	def birthday_soon(user, birthday_soon)
		user_all = User.all
		@birthday_soon = birthday_soon
		@user = user
		user_email = user_all.collect(&:email)
		user_email.delete(@user.email)
		mail 	to: user_email,
				subject: "Cкоро именины"
	end

	def birthday(user)
		@user = user
		mail 	to: @user.email,
				subject: "С днем рождения"
	end
end
