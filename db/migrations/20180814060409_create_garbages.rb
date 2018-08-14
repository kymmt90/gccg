Hanami::Model.migration do
  change do
    extension :pg_enum
    create_enum :segregation, %w(combustible non_combustible recyclable)

    create_table :garbages do
      primary_key :id

      column :segregation, :segregation, null: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
