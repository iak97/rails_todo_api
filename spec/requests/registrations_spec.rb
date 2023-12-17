require 'rails_helper'

RSpec.describe "Registrations", type: :request do
  describe 'POST /users/sign_up' do
    let(:user) { build(:user) }

    context 'with valid parameters' do
      before do
        post '/users', params: {
          user: {
            email: user.email,
            password: user.password,
            password_confirmation: user.password_confirmation
          }
        }
      end

      it 'creates a new user' do
        expect(response).to have_http_status(:ok)
        expect(json['status']['message']).to include("Signed up successfully.")
      end
    end

    context 'with invalid parameters' do
      before do
        post '/users', params: {
          user: {
            email: user.email,
            password: user.password,
            password_confirmation: ''
          }
        }
      end

      it 'does not create a new user' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['status']['message']).to include("User couldn't be created successfully. Password confirmation doesn't match Password")
      end
    end
  end
end

