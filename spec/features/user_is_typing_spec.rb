# require "rails_helper"
#
# RSpec.feature "chatrooms indicates when a user is typing", js: true do
#   let!(:chatroom1)    { create(:chatroom) }
#   let!(:chatroom2)    { create(:chatroom) }
#   let!(:user1_window) { open_new_window }
#   let!(:user2_window) { open_new_window }
#   let(:user1)         { create(:user) }
#   let(:user2)         { create(:user) }
#
#   before(:each) do
#     within_window(user1_window) do
#       login_as(user1)
#       visit "/"
#       click_link "#{chatroom1.topic}"
#     end
#
#     within_window(user2_window) do
#       login_as(user2)
#       visit "/"
#       click_link "#{chatroom1.topic}"
#     end
#   end
#
#   context "within the same chatroom" do
#     scenario "when someone else is typing", js: true do
#       within_window(user2_window) do
#         page.find("[data-user-typing='#{user2.username}']").trigger("click").send_keys("words")
#       end
#
#       within_window(user1_window) do
#         expect(page).to have_content "#{user2.username} is typing"
#       end
#     end
#
#     scenario "when typing yourself", js: true do
#       within_window(user1_window) do
#         elem = page.find("[data-user-typing='#{user1.username}']").trigger('click').send_keys("words")
#
#         expect(page).to_not have_content "#{user1.username} is typing"
#       end
#     end
#   end
#
#   context "within a different chatroom" do
#     scenario "when someone else is typing", js: true do
#       within_window(user2_window) do
#         fill_in "Post something", with: "words"
#       end
#
#       within_window(user1_window) do
#         expect(page).to_not have_content "#{user2.username} is typing"
#       end
#     end
#   end
# end
