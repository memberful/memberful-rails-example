require "rails_helper"

RSpec.feature "Sign in", :omniauth do

  scenario "user can sign in with valid account" do
    signin
    expect(page).to have_content("Sign out")
  end

  scenario "user cannot sign in with invalid account" do
    OmniAuth.config.mock_auth[:memberful] = :invalid_credentials
    visit root_path
    expect(page).to have_content("Sign in")
    click_link "Sign in"
    expect(page).to have_content("Authentication error")
  end

end
