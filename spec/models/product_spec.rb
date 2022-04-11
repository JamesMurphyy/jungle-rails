require 'rails_helper'

RSpec.describe Product, type: :model do
  
  let(:category) {
    Category.new(:name => "test")
  }

  subject {
    category.products.new(
      :name => "test_product",
      :price_cents => 10,
      :quantity => 1,
      :category => category
    )
  }

  describe 'Validations' do
    # validation tests/examples here
    it "validations are all valid and sucessfully displaying" do
      expect(subject).to be_valid
      expect(subject.errors.full_messages).to be_empty
    end

    it "validates name when name is nil" do
      subject.name = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include "Name can't be blank"
    end

    it "validates price when price is nil" do
      subject.price_cents = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include "Price can't be blank"
    end

    it "validates quantity when qualtity is nil" do
      subject.quantity = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include "Quantity can't be blank"
    end

    it "validates category when category is nil" do
      subject.category = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include "Category can't be blank"
    end
  end
end