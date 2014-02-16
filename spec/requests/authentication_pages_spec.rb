require 'spec_helper'

describe "AuthenticationPages" do
	subject {page}
	describe "signin page" do
		before { visit sign_in_path }
		it {should have_content("Sign in")}
		it {should have_title("Sign in")}
		
		describe "with invalid information" do
			before {click_button "Sign in"}
			it {should have_selector('div.alert.alert-error')}

			describe "after visiting another page" do
				before {click_link "Home"}
				it {should_not have_error_message('Invalid')}
			end
		end
		
		describe "with valid information" do
			let(:user) {FactoryGirl.create(:user)}
			before {valid_signin(user)}

			it {should have_title(user.name)}
			it {should have_link("Profile", href:user_path(user))}
			it {should have_link("Sign out", href:sign_out_path)}
			it {should_not have_link("Sign in", href:sign_in_path)}
			describe "foolowed by sign out" do
				before {click_link "Sign out"}
				it {should_not have_link("Sign out", href:sign_out_path)}
				it {should have_link("Sign in", href:sign_in_path)}
			end
		end
	end
end
