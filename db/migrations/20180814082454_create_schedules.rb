Hanami::Model.migration do
  change do
    create_table :schedules do
      primary_key :id
      foreign_key :calendar_id, :calendars, null: false, on_delete: :cascade
      foreign_key :garbage_id, :garbages, null: false, on_delete: :restrict

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
