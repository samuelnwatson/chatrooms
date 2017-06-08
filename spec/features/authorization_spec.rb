require 'rails_helper'

RSpec.feature "user authorizationa" do
  let(:user)  { create(:user) }
  let(:admin) { create(:user, :admin) }

  context "anonymous users" do
    scenario "cannot view admin page" do
      visit root_path

      expect(page).to_not have_content "Admin"
    end

    scenario "can't access admin page" do
      visit "/admin"
      expect(page).to have_content "You need to sign in or sign up before continuing."
    end
  end

  context "regular users" do
    before do
      login_as(user)
    end

    scenario "cannot view admin page" do
      visit root_path
      expect(page).to_not have_content "Admin"
    end

    scenario "can't access admin page" do
      visit "/admin"
      expect(page).to have_content "You are not admin."
    end
  end

  context "admin users" do
    before do
      login_as(admin)
    end

    scenario "can view admin page" do
      visit root_path
      expect(page).to have_content "Admin"
    end

    scenario "can access admin page" do
      visit "/admin"

      expect(page).to have_content "Chatrooms Admin Page"
    end
  end
end
