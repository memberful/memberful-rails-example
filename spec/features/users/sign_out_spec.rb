require "rails_helper"

RSpec.feature "Sign out", :omniauth do

  scenario "user signs out successfully" do
    signin
    click_link "Sign out"
    expect(page).to have_content "Signed out"
  end

end
