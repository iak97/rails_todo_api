class TodosController < ApplicationController
    before_action :authenticate_user!
    before_action :set_todo, only: %i[ show update destroy ]

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

    # PATCH/PUT /todos/1
    def update
        if @todo.update(todo_params)
            render json: @todo
        else
            render json: @todo.errors, status: :unprocessable_entity
        end
    end

    # DELETE /todos/1
    def destroy
        @todo.destroy
    end

    private

      def set_todo
        @todo = Todo.find_by(id: params[:id], user_id: current_user.id)
        render json: { error: "Couldn't find Todo" }, status: :not_found unless @todo
      end

      def todo_params
        params.require(:todo).permit(:title, :status).merge(user_id: current_user.id)
      end
end
