require 'rails_helper'

RSpec.feature "users can navigate from the home page to the product detail page by clicking on a product", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
      name:  Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
    )
    end
  end

  scenario "They see product details page" do
    # ACT
    visit root_path
    find_link("Details", :match => :first).click
    sleep 5
    # puts page.html
    # DEBUG
    save_screenshot

    # VERIFY
    expect(page).to have_content 'Price'
  end
end
