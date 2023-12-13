require 'rails_helper'

RSpec.describe "Todos", type: :request do
  let(:user) { create(:user) }
  let!(:todos) { create_list(:todo, 10, user: user) }

  before do
    sign_in user
  end

  describe "GET /todos" do
    
    before { get '/todos' }

    context 'when todos exist' do
      it 'returns todos' do
        expect(response).to have_http_status(:ok)

        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end
    end

    context 'when todos does not exist' do
      let(:todos) { }

      it 'returns empty' do
        expect(response).to have_http_status(:ok)

        expect(json).to be_empty
      end
    end
  end
end
