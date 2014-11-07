class Users::OmniauthCallbacksController <Devise::OmniauthCallbacksController
	def facebook
		@user = User.find_or_create_from_auth_hash find_or_create_from_auth_hash
		if @user.persisted?
			sing_in_and_redirect @user
		else
			session["device.user_attributes"] = @user.user_attributes
			redirect_to new_user_registration_url, notice: "Opps, somthing went wrong"
		end
	end

	private

	def auth_hash
			request.env['omniauth.auth']
	end
end