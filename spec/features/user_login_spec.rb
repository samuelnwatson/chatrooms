require "rails_helper"

RSpec.feature "User with an account can sign in" do
  let(:user) { create(:user) }
  let(:non_user) { build(:user) }

  before do
    visit root_path
  end

  context "without stored details" do
    scenario "can't sign-in via email" do
      fill_in "Email or username", with: non_user.email
      fill_in "Password", with: non_user.password

      click_on "Log in"

      expect(page).to have_content "Invalid Email or username or password"
    end
  end

  context "with stored details" do
    scenario "can sign-in via email" do
      fill_in "Email or username", with: user.email
      fill_in "Password", with: user.password
      click_on "Log in"

      expect(page).to have_content "Hi #{user.username}!"
    end

    scenario "can sign-in via username" do
      fill_in "Email or username", with: user.username
      fill_in "Password", with: user.password
      click_on "Log in"

      expect(page).to have_content "Hi #{user.username}!"
    end
  end
end
