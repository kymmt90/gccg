Hanami::Model.migration do
  change do
    create_table :schedule_details do
      primary_key :id
      foreign_key :schedule_id, :schedules, null: false, on_delete: :cascade

      column :day_of_week, Integer, null: false
      column :nth_week, Integer, null: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      check 'day_of_week BETWEEN 0 AND 6'
      check 'nth_week BETWEEN 1 AND 5'
    end
  end
end
