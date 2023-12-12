require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it "is valid with valid attributes" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "is atleast 8 characters present" do
      user = build(:user, password: 'Pass@12', password_confirmation: 'Password@12')
      expect(user).not_to be_valid
    end

    it "is atleast one uppercase present" do
      user = build(:user, password: 'pass@123', password_confirmation: 'pass@123')
      expect(user).not_to be_valid
    end

    it "is atleast one special character present" do
      user = build(:user, password: 'Pass1234', password_confirmation: 'Pass1234')
      expect(user).not_to be_valid
    end

    it "is atleast one number present" do
      user = build(:user, password: 'Password@', password_confirmation: 'Password@')
      expect(user).not_to be_valid
    end
  end
end
