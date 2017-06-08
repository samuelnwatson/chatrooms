require "rails_helper"

RSpec.feature "only update relevant chatrooms for users" do
  let(:user) { create(:user) }
  let!(:chatroom_one) { create(:chatroom) }
  let!(:chatroom_two) { create(:chatroom) }
  let(:chatroom_1) { open_new_window }
  let(:chatroom_2) { open_new_window }
  let(:chatroom_3) { open_new_window }
  let(:content) { Faker::TwinPeaks.quote }

  before do
    login_as(user)
  end

  context "with three chatrooms open in separate windows" do

    scenario "a post only updates it's related chatroom", js: true do
      within_window(chatroom_3) do
        visit root_path
        click_on "#{chatroom_one.topic}"
      end

      within_window(chatroom_2) do
        visit root_path
        click_on "#{chatroom_two.topic}"
      end

      within_window(chatroom_1) do
        visit root_path
        click_on "#{chatroom_one.topic}"

        fill_in "Post something", with: content
        click_on "Send"

        expect(page).to have_content content
      end

      within_window(chatroom_3) do
        expect(page).to have_content content
      end

      within_window(chatroom_2) do
        expect(page).to have_content "Chatroom: #{chatroom_two.topic}"
        expect(page).to_not have_content content
      end
    end
  end
end
