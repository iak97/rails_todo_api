require 'rails_helper'

RSpec.describe Todo, type: :model do
  context 'validation tests' do
    it "is valid with valid attributes" do
      todo = build(:todo)
      expect(todo).to be_valid
    end

    it "is not valid without a title" do
      todo = build(:todo, title: nil)
      expect(todo).not_to be_valid
    end

    it "is not valid without a status" do
      todo = build(:todo, status: nil)
      expect(todo).not_to be_valid
    end

    it "is not valid without a user" do
      todo = build(:todo, user: nil)
      expect(todo).not_to be_valid
    end
  end
end
