require 'rails_helper'

RSpec.describe "Sessions", type: :request do

    describe 'POST /users/sign_in' do
        let(:user) { create(:user) }

        context 'with valid parameters' do
            before { post '/users/sign_in', params: { user: { email: user.email, password: user.password } } }

            it 'creates a user session' do
                expect(response).to have_http_status(:ok)
                expect(json['status']['message']).to include("Logged in successfully.")
            end 
        end

        context 'with invalid parameters' do
            before { post '/users/sign_in', params: { user: { email: user.email, password: '' } } }

            it 'does not create a user session' do
                expect(response).to have_http_status(:unauthorized)
            end
        end
    end
end