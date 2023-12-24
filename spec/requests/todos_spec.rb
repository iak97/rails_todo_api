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

    context 'when todos do not exist' do
      let(:todos) { [] }

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
        expect(json['title']).to eq(todos.last.title)
        expect(json['status']).to eq(todos.last.status)
        expect(json['user_id']).to eq(todos.last.user_id)
      end
    end

    context 'when the record does not exist' do
      let(:todo_id) { 1000 }

      it 'returns a not found message' do
        expect(response).to have_http_status(:not_found)
        expect(response.body).to include("Couldn't find Todo")
      end
    end
  end

  describe "POST /todos" do
    let(:valid_todo_params) { { title: 'New Todo', status: 'todo' } }
    let(:invalid_todo_params) { { title: nil, status: 'todo' } }

    context 'when the request is valid' do
      before { post '/todos', params: { todo: valid_todo_params } }

      it 'creates a todo' do
        expect(response).to have_http_status(:created)
        expect(json['title']).to eq(valid_todo_params[:title])
        expect(json['status']).to eq(valid_todo_params[:status])
      end
    end

    context 'when the request is not valid' do
      before { post '/todos', params: { todo: invalid_todo_params } }

      it 'does not create a new todo' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['title']).to include("can't be blank")
      end
    end
  end

  describe "PUT /todos/:id" do
    let(:valid_todo_params) { { title: 'Updated Todo', status: 'done' } }
    let(:invalid_todo_params) { { title: nil, status: 'done' } }

    context 'when the record exists and is valid' do
      before { put "/todos/#{todo_id}", params: { todo: valid_todo_params } }

      it 'updates the record' do
        expect(response).to have_http_status(:ok)
        expect(json['title']).to eq(valid_todo_params[:title])
        expect(json['status']).to eq(valid_todo_params[:status])
      end
    end

    context 'when the record does not exist' do
      let(:todo_id) { 1000 }

      before { put "/todos/#{todo_id}", params: { todo: valid_todo_params } }

      it 'returns a not found message' do
        expect(response).to have_http_status(:not_found)
        expect(response.body).to include("Couldn't find Todo")
      end
    end

    context 'when the record exists and is not valid' do
      before { put "/todos/#{todo_id}", params: { todo: invalid_todo_params } }

      it 'does not update the record' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['title']).to include("can't be blank")
      end
    end
  end

  describe "DELETE /todos/:id" do
    context 'when the record exists' do
      before { delete "/todos/#{todo_id}" }

      it 'deletes the todo' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when the record does not exist' do
      let(:todo_id) { 1000 }

      before { delete "/todos/#{todo_id}" }

      it 'returns a not found message' do
        expect(response).to have_http_status(:not_found)
        expect(response.body).to include("Couldn't find Todo")
      end
    end
  end
end
