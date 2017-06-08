require "rails_helper"

RSpec.feature "users who have posted in chatrooms", js: true do
  let!(:chatroom) { create(:chatroom) }
  let!(:user1_window) { open_new_window }
  let!(:user2_window) { open_new_window }
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  before do
    within_window(user1_window) do
      login_as(user1)
      visit chatroom_path(chatroom)

      fill_in "Post something", with: "Hi"
      click_button "Send"
    end

    within_window(user2_window) do
      login_as(user2)
      visit root_path
    end
  end

  scenario "are displayed on page load" do
    within_window(user2_window) do
      visit chatroom_path(chatroom)

      expect(page).to have_content "Hi"
      expect(page).to have_content "#{user1.username}"
    end
  end

  scenario "are displayed realtime after posting" do
    within_window(user2_window) do
      visit chatroom_path(chatroom)

      fill_in "Post something", with: "Hello"
      click_button "Send"

      expect(page).to have_content "Hello"
      expect(page).to have_content "#{user2.username}"
    end

    within_window(user1_window) do
      expect(page).to have_content "#{user2.username}"
    end
  end
end
