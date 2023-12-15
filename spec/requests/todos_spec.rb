require 'rails_helper'

RSpec.describe "Todos", type: :request do
  let(:user) { create(:user) }
  let!(:todos) { create_list(:todo, 10, user: user) }
  let(:todo_id) { todos.last.id }

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

  describe "GET /todos/:id" do

    before { get "/todos/#{todo_id}" }

    context 'when the record exists' do
      it 'returns todo' do
        expect(response).to have_http_status(:ok)

        expect(json).not_to be_empty
        expect(json['id']).to eq(todo_id)
      end
    end

    context 'when the record does not exist' do
      let(:todo_id) { 1000 }

      it 'returns a not found message' do
        expect(response).to have_http_status(:not_found)

        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  describe "POST /todos" do
    let(:todo) { build(:todo) }

    context 'when the request is valid' do
      before { post '/todos', params: { todo: { title: todo.title, status: todo.status } } }

      it 'creates a todo' do
        expect(response).to have_http_status(:created)

        expect(json['title']).to eq(todo.title)
        expect(json['status']).to eq(todo.status)
      end
    end

    context 'when the request is not valid' do
      before { post '/todos', params: { todo: { title: todo.title, status: nil } } }

      it 'does not create a new todo' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
