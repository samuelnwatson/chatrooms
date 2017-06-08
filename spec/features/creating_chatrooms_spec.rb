require 'rails_helper'

RSpec.feature "Users can create chatrooms" do
  let(:user) { create(:user) }

  before do
    login_as(user)
  end

  context "with valid attributes" do
    scenario "when creating chatrooms" do
      visit root_path
      click_on "Create Chatroom"
      fill_in "Topic", with: "Testing with RSpec"
      fill_in "Description", with: "test description"

      click_button "Create Chatroom"

      expect(page).to have_content "Chatroom: Testing with RSpec"
      expect(page).to have_content "test description"
    end

    scenario "can view created chatroom in homepage" do
      visit root_path
      click_on "Create Chatroom"
      fill_in "Topic", with: "About RSpec"

      click_button "Create Chatroom"
      click_link "Chatrooms"

      expect(page).to have_content "About RSpec"
    end
  end

  context "with invalid attributes" do
    scenario "when topic left blank" do
      visit root_path
      click_on "Create Chatroom"
      fill_in "Topic", with: ""
      fill_in "Description", with: ""

      click_on "Create Chatroom"

      expect(page).to have_content "Topic can't be blank"
    end

    scenario "when topic set to new" do
      visit root_path
      click_on "Create Chatroom"
      fill_in "Topic", with: "new"
      fill_in "Description", with: ""

      click_on "Create Chatroom"

      expect(page).to have_content "new is reserved."
    end
  end
end
