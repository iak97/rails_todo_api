class TodosController < ApplicationController
    before_action :authenticate_user!

    # GET /todos
    def index
        @todos = Todo.where(user_id: current_user.id)

        render json: @todos
    end

end
