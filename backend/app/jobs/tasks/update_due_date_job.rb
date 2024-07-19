module Tasks
  class UpdateDueDateJob < ApplicationJob
    queue_as :default

    def perform(due_date) = Task.update_all(due_date: due_date)
  end
end
