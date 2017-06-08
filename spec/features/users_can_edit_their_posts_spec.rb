require "rails_helper"

RSpec.describe "editing posts" do
  let! :chatroom { create :chatroom }
  let :author    { create :user }
  let :user      { create :user }
  let! :post     { create :post, chatroom: chatroom, user: author }

  context "when not the post author" do
    scenario "cannot edit the post" do
      login_as user
      visit chatroom_path chatroom

      expect(page).to_not have_content "[ Edit Post ]"
    end
  end

  context "when the post author" do
    scenario "can edit the post" do
      login_as author
      visit chatroom_path chatroom

      expect(page).to have_content "[ Edit Post ]"
      click_on "[ Edit Post ]"
      fill_in "Post something", with: "edited"
      click_on "Send"

      expect(page).to have_content "edited"
    end
  end
end
