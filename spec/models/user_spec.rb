require 'rails_helper'

RSpec.describe User, type: :model do
  
  subject {
    User.new(
      :name => "test_name",
      :email => "test@test.com",
      :password => "test123",
      :password_confirmation => "test123"
    )
  }
  
  describe 'Validations' do
    it 'should create valid user' do
      expect(subject).to be_valid
      expect(subject.errors.full_messages).to be_empty
    end
    it 'should have a name' do
      subject.name = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include "Name can't be blank"
    end
    it 'should have an email' do
      subject.email = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include "Email can't be blank"
    end

    it 'should have a password confirmation' do
      subject.password_confirmation = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include "Password confirmation can't be blank"
    end

    it 'should have a password confirmation' do
      subject.password = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include "Password can't be blank"
    end

    it 'should have a matching password and password confirmation' do
      subject.password_confirmation = "test12"
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include "Password confirmation doesn't match Password"
    end

    it 'should have a password and password confirmation of minimum length of 3' do
      subject.password = "te"
      subject.password_confirmation = "te"
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include "Password is too short (minimum is 3 characters)"
    end

    it 'should not save without unique email' do
      User.create(
        :name => "test_name",
        :email => "TEST@TEST.com",
        :password => "test123",
        :password_confirmation => "test123"
      )
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include "Email has already been taken"
    end
  end

  describe '.authenticate_with_credentials' do

    it "should authenticate if sucessful" do
      subject.save!
      user_test = User.authenticate_with_credentials(subject.email, subject.password)
      expect(user_test).to eq (subject)
    end

    it "should authenticate if spaces before/after email" do
      subject.save!
      user_test = User.authenticate_with_credentials(" test@test.com ", subject.password)
      expect(user_test).to eq (subject)
    end

    it "should authenticate if capitalized letter on accident" do
      subject.save!
      user_test = User.authenticate_with_credentials("TesT@test.com", subject.password)
      expect(user_test).to eq (subject)
    end

    it "should return nil if unsuccesful authenticate" do
      subject.save!
      user_test = User.authenticate_with_credentials("email@email.com", subject.password)
      expect(user_test).to eq (nil)
    end
  end
end