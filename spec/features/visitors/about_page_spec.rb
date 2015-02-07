require "rails_helper"

RSpec.feature "About page" do
  scenario "Visit the about page" do
    visit "pages/about"
    expect(page).to have_content "About the Website"
  end
end
