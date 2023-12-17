require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    let(:valid_attributes) { { password: 'Pass@1234', password_confirmation: 'Pass@1234' } }

    it "is valid with valid attributes" do
      user = build(:user, valid_attributes)
      expect(user).to be_valid
    end

    it "requires at least 8 characters" do
      user = build(:user, password: 'Pass@12', password_confirmation: 'Password@12')
      expect(user).not_to be_valid
    end

    it "requires at least one uppercase letter" do
      user = build(:user, password: 'pass@123', password_confirmation: 'pass@123')
      expect(user).not_to be_valid
    end

    it "requires at least one special character" do
      user = build(:user, password: 'Pass1234', password_confirmation: 'Pass1234')
      expect(user).not_to be_valid
    end

    it "requires at least one number" do
      user = build(:user, password: 'Password@', password_confirmation: 'Password@')
      expect(user).not_to be_valid
    end
  end
end
