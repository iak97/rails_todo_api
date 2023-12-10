class Todo < ApplicationRecord
    belongs_to :user
    enum status: { todo: 0, in_progress: 1, done: 2 }

    validates :title, presence: true
    validates :status, presence: true
end
