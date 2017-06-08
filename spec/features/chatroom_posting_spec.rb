require "rails_helper"

RSpec.feature "Users visiting a chatroom" do

  let(:user)      { create(:user) }
  let!(:chatroom) { create(:chatroom) }

  context "anonymous users" do
    scenario "can't see any chatrooms if not logged in" do
      visit  root_path
      expect(page).to_not have_content "#{chatroom.topic}"
    end
  end

  context "signed-in users" do
    scenario "can see chatroom once logged in" do
      visit root_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_on "Log in"

      expect(page).to have_content "#{chatroom.topic}"
    end

    scenario "can post to chatroom", js: true do
      login_as(user)
      visit root_path
      click_on "#{chatroom.topic}"

      expect(page).to have_content "Chatroom: #{chatroom.topic}"

      fill_in "Post something", with: "Hi chatrooms!"
      click_on "Send"

      expect(page).to have_content "Hi chatrooms!"
      expect(page).to have_content "- #{user.username}"
    end
  end
end
