class ScheduleRepository < Hanami::Repository
  associations do
    belongs_to :calendar
    belongs_to :garbage

    has_many :schedule_details
  end
end
