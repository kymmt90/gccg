Hanami::Model.migration do
  change do
    create_table :calendars do
      primary_key :id

      column :title, String, null: false
      column :starts_on, Date, null: false
      column :ends_on, Date, null: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
