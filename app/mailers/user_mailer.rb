class UserMailer < ApplicationMailer
	default from: 'no-reply@blogger.com'
	layout 'custom_mailer'

	def welcome(user)
		@user = user
		@url  = 'http://vik-blog.herokuapp.com'
		mail(to: @user.email, subject: 'Welcome to My Awesome Blog')
	end
end
