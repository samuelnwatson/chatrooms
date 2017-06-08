require "rails_helper"

RSpec.feature "Only admins are authorized for admin pages" do

  context "as an admin user" do
    scenario "Admins can visit admin index" do
      login_as(create(:user, :admin))
      visit root_path
      click_on "Admin"

      expect(page).to have_content "Chatrooms Admin Page"
    end
  end

  context "as a non-admin user" do
    scenario "Non-admin users can't visit admin index" do
      login_as(create(:user))
      visit "/admin"

      expect(page).to have_content "You are not admin."
    end
  end
end
