include ApplicationHelper

def valid_signin(user)
	fill_in "Email", 	with: user.email
	fill_in "Password",	with: user.password
	click_button "Sign in"
end

RSpec::Matchers.define :have_error_message do |message|
	match do |page|
		page.should have_selector('div.alert.alert-error', text: message)
	end
end

def sign_in(user, edit_path = false)
	
	if edit_path
		visit edit_user_path(user)
	else
		visit signin_path
	end
	
	valid_signin(user)
	
	# Sign in when not using Capybara as well
	cookies[:remember_token] = user.remember_token
end
	