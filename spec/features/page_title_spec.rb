require "rails_helper"

RSpec.describe "title names in the browser" do
  let!(:chatroom) { create(:chatroom) }
  let(:user) { create(:user) }

  before do
    login_as user
    visit chatroom_path chatroom
  end

  scenario "inside a chatroom, the topic is in the title bar" do
    assert_title chatroom.topic
  end
end
