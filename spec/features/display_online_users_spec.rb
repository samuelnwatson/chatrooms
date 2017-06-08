require "rails_helper"

RSpec.feature "online status of users is displayed", js: true do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let!(:chatroom) { create(:chatroom) }
  let!(:user1_window) { open_new_window }
  let!(:user2_window) { open_new_window }

  before(:each) do
    within_window(user1_window) do
      login_as(user1)
      visit root_path
      click_on "#{chatroom.topic}"
    end

    within_window(user2_window) do
      login_as(user2)
      visit root_path
      click_on "#{chatroom.topic}"

      fill_in "Post something", with: "Hi"
      click_on "Send"
    end
  end

  context "when online" do
    scenario "a user visits chatroom" do
      within_window(user1_window) do
        expect(page).to have_content "*#{user2.username}"
      end
    end
  end

  context "when offline" do
    scenario "a user leaves chatroom" do
     user2_window.close

      within_window(user1_window) do
        expect(page).to_not have_content "*#{user2.username}"
      end
    end
  end
end
