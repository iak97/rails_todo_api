#./spec/requests/registrations_spec.rb
require 'rails_helper'

RSpec.describe "Registrations", type: :request do

    describe 'POST /users/sign_up' do
        let(:user) { build(:user) }

        context 'when the request is valid' do
            before { post '/users', params: { user: { email: user.email, password: user.password, password_confirmation: user.password_confirmation } } }

            it 'creates a new user' do
                expect(response).to have_http_status(:ok)
            end
        end
    end

end
