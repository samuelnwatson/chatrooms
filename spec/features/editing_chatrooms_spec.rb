require "rails_helper"

RSpec.describe "editing existing chatrooms" do
  let(:admin)     { create(:user, admin: true) }
  let(:creator)   { create(:user) }
  let!(:user)     { create(:user) }
  let!(:chatroom) { create(:chatroom, creator: creator.username) }

  context "when admin" do
    scenario "editing the chatroom" do
      login_as(admin)
      visit edit_chatroom_path(chatroom)

      fill_in "Topic", with: "edited"
      click_on "Update Chatroom"

      expect(page).to have_content "edited"
    end
  end

  context "when the chatroom creator" do
    scenario "editing the chatroom" do
      login_as(creator)
      visit edit_chatroom_path(chatroom)

      fill_in "Topic", with: "edited"
      click_on "Update Chatroom"

      expect(page).to have_content "edited"
    end
  end

  context "when not the chatroom creator" do
    scenario "cannot see edit chatroom link" do
      login_as(user)
      visit chatroom_path(chatroom)

      expect(page).to_not have_content "[ Edit Chatroom ]"
    end
  end
end
