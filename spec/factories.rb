FactoryGirl.define do
	factory :user do
		sequence(:name) {|n| "Person #{n}"}
		sequence(:email) {|n| "email-#{n}@mail.ru"}
		password "123123123"
		password_confirmation "123123123"
		factory :admin do
			admin true
		end
	end
end