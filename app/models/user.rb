class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :user_avatar
	validates_attachment_content_type :user_avatar, content_type: /\Aimage\/.*\z/

  has_many 		:tascs, dependent: :destroy
  belongs_to	:group


  	def self.when_birthday
  		FirstJob.perform_later
  	end

  	def self.bd_user_soon
  		User.all.each do|user|
	  		unless (user.birthday_user.nil?)
				birthday = user.birthday_user.utc
				now = Time.now.utc.change(hour: 21)
				birthday_to = birthday.change(year: now.year, hour: 21 )+1.year

				birthday_soon = birthday_to.to_i - now.to_i
				birthday_soon = sec2d(birthday_soon)
				
				if birthday_soon == 365
					TaskMailer.birthday(user).deliver
					TaskMailer.birthday_soon(user, birthday_soon).deliver
				elsif birthday_soon <= 5
					TaskMailer.birthday_soon(user, birthday_soon).deliver
				end
			end
		end
	end

	def self.sec2d(seсs)
		days 	= 	seсs.round      
		days 	/= 	86400                              
		days    
	end


end
