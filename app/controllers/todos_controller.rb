class TodosController < ApplicationController
    before_action :authenticate_user!
    before_action :set_todo, only: %i[ show ]

    # GET /todos
    def index
        @todos = Todo.where(user_id: current_user.id)

        render json: @todos
    end

    # GET /todos/1
    def show
        render json: @todo
    end

    # POST /todos
    def create
        @todo = Todo.new(todo_params)

        if @todo.save
            render json: @todo, status: :created, location: @todo
        else
            render json: @todo.errors, status: :unprocessable_entity
        end
    end

    private

      def set_todo
        @todo = Todo.find(params[:id])
      end

      def todo_params
        params.require(:todo).permit(:title, :status).merge(user_id: current_user.id)
      end
end
