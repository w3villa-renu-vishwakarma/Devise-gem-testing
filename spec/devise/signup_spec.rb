require "rails_helper"

describe "User signs up", type: :system do
    let(:email) { Faker::Internet.email }
    let(:password) { Faker::Internet.password(min_length: 8) }
  before do
    visit new_user_registration_path 
  end

  it "registration valid with correct credentials" do
    fill_in "user_email", with: email
    fill_in "user_password", with: password
    fill_in "user_password_confirmation", with: password
    click_button "Sign up"
    expect(page).to have_content("Welcome! You have signed up successfully.")

  end

  it "registartion invalid if password not match" do
    fill_in "user_email", with: email
    fill_in "user_password", with: password
    fill_in "user_password_confirmation", with: Faker::Internet.password(min_length: 8)
    click_button "Sign up"
    expect(page).to have_content("Password confirmation doesn't match Password")
  end
  
  it "registration invalid if password is not valid" do
    fill_in "user_email", with: email
    fill_in "user_password", with: "1234"
    fill_in "user_password_confirmation", with: "1234"
    click_button "Sign up"
    expect(page).to have_content("Password is too short (minimum is 6 characters)")
  end
  
  it "registration invalid if user is already registered" do
    @user = create :user
    fill_in "user_email", with: @user.email
    fill_in "user_password", with: password
    fill_in "user_password_confirmation", with: password
    click_button "Sign up"
    expect(page).to have_content("Email has already been taken")
  end
end