require 'rails_helper'

RSpec.feature "users can login successfully and are taken to the home page once they are signed in", type: :feature, js: true do
  before :each do
    User.create!(
        :name => "test_name",
        :email => "test@test.com",
        :password => "test123",
        :password_confirmation => "test123"
      )
  end

  scenario "They see logged in following login" do
    # ACT
    visit root_path
    puts page.html
    click_link("Login")
    sleep 5
    # DEBUG
    
    puts page.html
    fill_in 'email', with: 'test@test.com'
    fill_in 'password', with: 'test123'
    click_button("Submit")
    save_screenshot

    # VERIFY
    expect(page).to have_content "Signed in as"
  end
end
