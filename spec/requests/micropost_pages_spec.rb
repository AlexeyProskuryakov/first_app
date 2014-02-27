require 'spec_helper'

describe "Micropost Pages" do
	subject {page}
	let(:user) {FactoryGirl.create(:user)}
	before {sign_in user}
	describe "micropost creation" do 
		before {visit root_path}
		describe "with invalid information" do 
			it "should not create micropost" do 
				expect { click_button "Post"}.not_to change(Micropost, :count)
			end
			describe "error message" do
				before { click_button "Post" }
				it {should have_content("error")}
			end
		end
		describe "with valid information" do
			before {fill_in "micropost_content", with: "Lorem Ipsum"}
			it "should create micropost" do
				expect {click_button "Post"}.to change(Micropost, :count).by(1)
			end
		end
	end
	describe "micropost destroy" do
		before {FactoryGirl.create(:micropost, user: user)}
		describe "as correct user" do
			before { visit root_path }

			it "should delete a micropost" do
				expect { click_link "delete" }.to change(Micropost, :count).by(-1)
			end
		end
		describe "as incorrect user" do
			before do 
				another_user = FactoryGirl.create(:user)
				FactoryGirl.create(:micropost, user: another_user)
				visit user_path(another_user)	
			end
			it {should_not have_link('delete')}
		end
	end
	describe "microposts count and pagination" do 
		before do
			another_user = FactoryGirl.create(:user)
			31.times {FactoryGirl.create(:micropost, user: another_user)}
			visit user_path(another_user)
		end
		it {should have_content('31')}
		it {should have_selector('div.pagination')}
	end
end
