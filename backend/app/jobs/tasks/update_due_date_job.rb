module Tasks
  class UpdateDueDateJob < ApplicationJob
    queue_as :default

    def perform(args) = Task.update_all(due_date: args[:due_date])
  end
end
