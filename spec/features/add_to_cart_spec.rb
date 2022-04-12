require 'rails_helper'

RSpec.feature "users can click the 'Add to Cart' button for a product on the home page and in doing so their cart increases by one", type: :feature, js: true do
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

  scenario "They see cart increase by 1" do
    # ACT
    visit root_path
    # puts page.html
    click_button("Add", :match => :first)
    sleep 5
    # DEBUG
    save_screenshot
    
    # puts page.html
    # VERIFY
    expect(page).to have_content "My Cart (1)"
  end
end
