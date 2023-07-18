require "rails_helper"

describe "User signs in", type: :system do
  before do
    @user = create :user
    visit new_user_session_path
  end

  it "valid with correct credentials" do
    fill_in "user_email", with: @user.email
    fill_in "user_password", with: @user.password
    click_button "Log in"
    expect(page).to have_text "Home#index"
    expect(page).to have_current_path root_path
    expect(page).to have_link "Logout"
  end

  it "invalid with unregistered account" do
    fill_in "user_email", with: Faker::Internet.email
    fill_in "user_password", with: "Fakepassword123"
    click_button "Log in"
    expect(page).to have_no_text "Home#index"
    expect(page).to have_text "Invalid Email or password"
    expect(page).to have_current_path new_user_session_path
    expect(page).to have_no_link "Logout"

  end

  it "invalid with invalid password" do
    fill_in "user_email", with: @user.email
    fill_in "user_password", with: "Fakepassword123"
    click_button "Log in"
    expect(page).to have_no_text "Home#index"
    expect(page).to have_text "Invalid Email or password"
    expect(page).to have_current_path new_user_session_path
    expect(page).to have_no_link "Logout"
  end
  
  

end