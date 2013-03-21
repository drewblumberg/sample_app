FactoryGirl.define do
	factory :user do
		name					"Drew Blumberg"
		email					"dblumberg@example.com"
		password				"foobar"
		password_confirmation	"foobar"
	end
end