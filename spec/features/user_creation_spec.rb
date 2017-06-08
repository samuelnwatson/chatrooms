require "rails_helper"

RSpec.feature "Can create User via sign up page" do
  before do
    visit root_path
    click_on "Sign Up"
  end

  scenario "with valid details" do
    fill_in "Email", with: "email@example.com"
    fill_in "Username", with: "some_username"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Sign up"

    expect(page).to have_content "Welcome! You have signed up successfully."
    expect(page).to have_content "Hi some_username!"
  end

  scenario "with invalid credentials" do
    fill_in "Email", with: ""
    fill_in "Username", with: ""
    fill_in "Password", with: ""
    fill_in "Password confirmation", with: ""
    click_on "Sign up"

    expect(page).to have_content "Email can't be blank"
    expect(page).to have_content "Username can't be blank"
    expect(page).to have_content "Password can't be blank"
    expect(page).to have_content "Password (6 characters minimum)"
  end
end
