# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

5.times do
  Task.create(
    title:       Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph,
    due_date:    Faker::Date.birthday
  )
end
