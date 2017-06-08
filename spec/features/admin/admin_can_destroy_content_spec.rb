require "rails_helper"

RSpec.feature "Admin users can destroy content" do
  let!(:chatroom) { create(:chatroom, creator: creator.username) }
  let(:admin)     { create(:user, :admin) }
  let!(:user)     { create(:user) }
  let!(:creator)  { create(:user) }
  let!(:post)     { create(:post, user: user, chatroom: chatroom) }

  context "non-admin" do
    scenario "cannot see link to destroy chatroom" do
      login_as(user)
      visit (chatroom_path(chatroom))

      expect(page).to_not have_content "Delete Chatroom"
    end

    scenario "can see link if the creator of chatroom" do
      login_as(creator)
      visit chatroom_path(chatroom)

      expect(page).to have_content "[ Delete Chatroom ]"
      click_on "Delete Chatroom"

      expect(page).to have_content "Chatroom Deleted"
      expect(page).to_not have_content "#{chatroom.topic}"
    end
    # remove uneccessary brackets
    scenario "canot see link to destroy posts" do
      login_as(user)
      visit chatroom_path(chatroom)

      expect(page).to_not have_content "[ Delete Post ]"
    end
  end

  context "while admin" do
    scenario "when destroying chatrooms" do
      login_as(admin)
      visit chatroom_path(chatroom)
      click_on "Delete Chatroom"

      expect(page).to have_content "Chatroom Deleted"
      expect(page).to_not have_content "#{chatroom.topic}"
    end

    scenario "when destroying posts" do
      login_as(admin)
      visit (chatroom_path(chatroom))

      click_link "[ Delete Post ]"
      expect(page).to have_content "Post Deleted"
    end
  end
end
